module Books
  class BatchController < ApplicationController
    def update
      @books = Book.find params[:ids]
      begin
        Book.transaction do
          @books.each do |book|
            book.attributes = params[:book]
            book.save!
          end
        end
      rescue
        flash[:error] = 'There was a problem changing the book recommendations.'
        redirect_to books_path and return
      end

      flash[:success] = 'You have successfully updated the books.'
      redirect_to books_path
    end
  end
end
