class Bins::BooksController < Books::BaseController
  def find_context
    @bin = Bin.find(params[:bin_id])
    @context = Book.where(:bin_id => @bin.id)
  end
end
