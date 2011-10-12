require 'spec_helper'

describe BooksHelper do

  describe "#link_to_book_facet" do
    context "given we're viewing All books" do
      before(:each) { params[:recommendation] = nil }

      it "should not link :all" do
        link_to_book_facet(:all).should include(content_tag(:span, "All (#{Book.count})"))
      end

      it "should link :trash" do
        link_to_book_facet(:trash).should include(link_to "Trash (#{Book.trash.count})", books_path(recommendation: :trash))
      end
    end
    
    context "given we're viewing Keep books" do
      before(:each) { params[:recommendation] = 'keep' }

      it "should not link :keep" do
        link_to_book_facet(:keep).should include(content_tag(:span, "Keep (#{Book.keep.count})"))
      end

      it "should link :all, :trash" do
        link_to_book_facet(:all).should include(link_to "All (#{Book.count})", books_path)
        link_to_book_facet(:undecided).should include(link_to "Undecided (#{Book.undecided.count})", books_path(recommendation: :undecided))
        link_to_book_facet(:trash).should include(link_to "Trash (#{Book.trash.count})", books_path(recommendation: :trash))
      end
    end
  end

  describe "#book_thumbnail(book)" do
    before(:each) do
      @book = Factory.create(:book)
    end
    context "given the book doesn't have a thumbnail" do
      before(:each) do
        @book.update_attribute(:thumbnail, '')
      end
      it 'returns "No thumbnail"' do
        book_thumbnail(@book).should eq("No thumbnail")
      end
    end
    context "given the book has a thumbnail" do
      it 'returns an image tag of the thumbnail' do
        book_thumbnail(@book).should eq(image_tag(@book.thumbnail))
      end
    end
  end
end
