class Bins::BooksController < ApplicationController
  respond_to :html

  def index
    @bin = Bin.find(params[:bin_id])
    @books = @bin.books.send(current_scope)

    respond_with @bin, @books
  end

  def show
    @bin = Bin.find(params[:bin_id])
    @book = @bin.books.find(params[:id])

    respond_with @bin, @book
  end

  def new
    @bin = Bin.find(params[:bin_id])
    @book = @bin.books.build

    respond_with @bin, @book
  end

  def edit
    @bin = Bin.find(params[:bin_id])
    @book = @bin.books.find(params[:id])

    respond_with @bin, @book
  end

  def create
    @bin = Bin.find(params[:bin_id])
    @book = @bin.books.build(params[:book])

    # Save the last donor to speed up the process
    session[:donor_id] = params[:book][:donor_id]

    @book.attributes = OCLC.find_by_isbn(@book.isbn)
    @book.attributes = AMZN.find_by_isbn(@book.isbn)

    if @book.save
      redirect_to bin_book_path(@bin, @book), :notice => 'You successfully created a book.'
    else
      render :new
    end
  end

  def update
    @bin = Bin.find(params[:bin_id])
    @book = @bin.books.find(params[:id])

    @book.attributes = params[:book]

    if @book.save
      if params[:book][:recommendation]
        notice = "The book's recommendation has been updated to: keep." if params[:book][:recommendation] == 'keep'
        notice = "The book's recommendation has been updated to: toss." if params[:book][:recommendation] == 'toss'
        notice = "The book's recommendation has been updated to: undecided." if params[:book][:recommendation] == 'undecided'
      else
        notice = "You successfully updated the book."
      end
      redirect_to bin_book_path(@bin, @book), :notice => notice
    else
      render :edit
    end
  end

  def destroy
    @bin = Bin.find(params[:bin_id])
    @book = @bin.books.find(params[:id])

    if @book.destroy
      redirect_to @bin, :notice => 'You successfully removed the book.'
    else
      flash[:error] = 'There was problem removing the book. Please try again.'
      redirect_to @bin
    end
  end

  def current_scope
    Book.scopes.keys.include?(params[:scope].try(:to_sym)) ? params[:scope] : 'all'
  end
end
