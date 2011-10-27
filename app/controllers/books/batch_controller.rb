class BatchController < ApplicationController
  def update
    params.keys.each do |k|
      next unless k =~ /^book-(\d+)$/
      book = Book.find($1)
      book.attributes = params[:book]

      book.save
    end

    flash[:notice] = 'You have successfully changed the recommendations.'
    redirect_to books_path
  end
end
