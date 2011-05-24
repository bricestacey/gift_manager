class BooksController < ApplicationController
  respond_to :html

  def index
    @books = Book.send(current_scope)

    respond_with @books
  end

  def show
    @book = Book.find(params[:id])

    respond_with @book
  end

  def new
    @book = Book.new

    respond_with @book
  end

  def edit
    @book = Book.find(params[:id])

    respond_with @book
  end

  def create
    @book = Book.new(params[:book])

    # Save the last donor to speed up the process
    session[:donor_id] = params[:book][:donor_id]

    @book.attributes = OCLC.find_by_isbn(@book.isbn)
    @book.attributes = AMZN.find_by_isbn(@book.isbn)

    if @book.save
      redirect_to @book, :notice => 'You successfully added a book.'
    else
      render :new
    end
  end

  def update
    @book = Book.find(params[:id])

    @book.attributes = params[:book]

    if @book.save
      if params[:book][:recommendation]
        notice = "The book's recommendation has been updated to: keep." if params[:book][:recommendation] == 'keep'
        notice = "The book's recommendation has been updated to: toss." if params[:book][:recommendation] == 'toss'
        notice = "The book's recommendation has been updated to: undecided." if params[:book][:recommendation] == 'undecided'
      else
        notice = "You successfully updated the book."
      end
      redirect_to @book, :notice => notice
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])

    if @book.destroy
      redirect_to books_path, :notice => 'You successfully deleted the book.'
    else
      flash[:error] = 'There was problem removing the book. Please try again.'
      redirect_to books_path
    end
  end

  def current_scope
    Book.scopes.keys.include?(params[:scope].try(:to_sym)) ? params[:scope] : 'all'
  end
end
