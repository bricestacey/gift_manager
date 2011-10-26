class Books::RecommendationController < ApplicationController
  def update
    @book = Book.find(params[:id])
    @book.recommendation = params[:book][:recommendation]

    if @book.save
      flash[:notice] = "The book's recommendation has been updated to: #{params[:book][:recommendation].capitalize}."
      redirect_to @book
    else
      flash[:error] = "There was a problem updating the book's recommendation."
      redirect_to @book
    end
  end
end
