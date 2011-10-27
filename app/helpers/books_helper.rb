module BooksHelper

  def link_to_book_facet(val)
    text = "#{val.to_s.capitalize} (#{Book.send(val).count})"

    if params[:recommendation] == val.to_s
      link_to text, books_path(recommendation: val), class: 'btn primary'
    elsif val == :all
      link_to text, books_path, class: "btn #{params[:recommendation].blank? ? 'primary' : ''}"
    else
      link_to text, books_path(recommendation: val), class: 'btn'
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
