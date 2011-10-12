class BooksController < ApplicationController
  respond_to    :html
  before_filter :find_book, :only => [:show, :edit, :update, :destroy]

  def index
    @books = Book.page params[:page]

    # Allow filtering by donor, bin, or recommendation
    @books = @books.where(donor_id: params[:donor]) if params[:donor]
    @books = @books.where(bin_id: params[:bin]) if params[:bin]
    @books = @books.where(recommendation: params[:recommendation]) if params[:recommendation]
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(params[:book])

    # Save the last donor to speed up the process
    session[:donor_id] = params[:book][:donor_id]

    unless @book.isbn.blank?
      @book.attributes = OCLC.attributes_for_isbn(@book.isbn)
      @book.attributes = AMZN.attributes_for_isbn(@book.isbn)
    end

    if @book.save
      flash[:notice] = 'You successfully added a book.'
      redirect_to :action => 'show', :id => @book.id
    else
      flash.now[:error] = 'There was a problem adding the book.'
      render :new
    end
  end

  def update
    @book.attributes = params[:book]

    if @book.save
      flash[:notice] = "You successfully updated the book."
      redirect_to action: 'show', id: @book.id
    else
      flash.now[:error] = 'There was a problem updating the book.'
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:notice] = 'You successfully deleted the book.'
      redirect_to :action => 'index'
    else
      flash[:error] = 'There was a problem deleting the book.'
      redirect_to @book
    end
  end

  private
  def find_book
    @book = Book.find(params[:id])
  end
end
