module BooksHelper
  def book_thumbnail(book)
    if book.thumbnail.blank?
      "No thumbnail"
    else
      image_tag(book.thumbnail)
    end
  end
end
