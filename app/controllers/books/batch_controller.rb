module Books
  class BatchController < ApplicationController
    # params[:ids] should contain an array of Book ids.
    # Any attributes that should be batch changed on the collection
    # of ids should be nested in a params[:book] hash.
    def update
      @books = Book.find params[:ids]
      begin
        Book.transaction do
          @books.each do |book|
            # params[:book] will contain some attributes that are blank.
            # Since batch operations are not used where blank values are
            # possible, we only want to mass-assign values that are present.
            book.attributes = params[:book].select{|k, v| v.present?}
            book.save!
          end
        end
      # We use save! in order to rollback the transaction. Here we catch it.
      # We can specify ActiveRecord::RecordInvalid, but it made testing more
      # difficult
      rescue
        flash[:error] = 'There was a problem changing the books.'
        redirect_to books_path and return
      end

      flash[:success] = 'You have successfully updated the books.'
      redirect_to books_path
    end
  end
end
