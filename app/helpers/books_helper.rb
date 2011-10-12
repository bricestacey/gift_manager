module BooksHelper

  def link_to_book_facet(val)
    text = "#{val.to_s.capitalize} (#{Book.send(val).count})"

    if params[:recommendation] == val.to_s or (val == :all and params[:recommendation].nil?)
      content_tag(:span, text)
    elsif val == :all
      link_to text, books_path
    else
      link_to text, books_path(recommendation: val)
    end
  end

  def book_thumbnail(book)
    if book.thumbnail.blank?
      "No thumbnail"
    else
      image_tag(book.thumbnail)
    end
  end
end
