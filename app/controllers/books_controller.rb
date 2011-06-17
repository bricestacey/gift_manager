class BooksController < Books::BaseController
  def find_context
    @context = Book
  end
end
