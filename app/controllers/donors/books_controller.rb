class Donors::BooksController < ApplicationController
  respond_to :html

  def index
    @donor = Donor.find(params[:donor_id])
    @books = @donor.books.send(current_scope)

    respond_with @donor, @books
  end

  def show
    @donor = Donor.find(params[:donor_id])
    @book = @donor.books.find(params[:id])

    respond_with @donor, @book
  end

  def new
    @donor = Donor.find(params[:donor_id])
    @book = @donor.books.build

    respond_with @donor, @book
  end

  def edit
    @donor = Donor.find(params[:donor_id])
    @book = @donor.books.find(params[:id])

    respond_with @donor, @book
  end

  def create
    @donor = Donor.find(params[:donor_id])
    @book = @donor.books.build(params[:book])

    # Save the last donor to speed up the process
    session[:donor_id] = params[:book][:donor_id]

    @book.attributes = OCLC.find_by_isbn(@book.isbn)
    @book.attributes = AMZN.find_by_isbn(@book.isbn)

    if @book.save
      redirect_to donor_book_path(@donor, @book), :notice => 'You successfully created a book.'
    else
      render :new
    end
  end

  def update
    @donor = Donor.find(params[:donor_id])
    @book = @donor.books.find(params[:id])

    @book.attributes = params[:book]

    if @book.save
      if params[:book][:recommendation]
        notice = "The book's recommendation has been updated to: keep." if params[:book][:recommendation] == 'keep'
        notice = "The book's recommendation has been updated to: toss." if params[:book][:recommendation] == 'toss'
        notice = "The book's recommendation has been updated to: undecided." if params[:book][:recommendation] == 'undecided'
      else
        notice = "You successfully updated the book."
      end
      redirect_to donor_book_path(@donor, @book), :notice => notice
    else
      render :edit
    end
  end

  def destroy
    @donor = Donor.find(params[:donor_id])
    @book = @donor.books.find(params[:id])

    if @book.destroy
      redirect_to @donor, :notice => 'You successfully removed the book.'
    else
      flash[:error] = 'There was problem removing the book. Please try again.'
      redirect_to @donor
    end
  end

  def current_scope
    Book.scopes.keys.include?(params[:scope].try(:to_sym)) ? params[:scope] : 'all'
  end
end
