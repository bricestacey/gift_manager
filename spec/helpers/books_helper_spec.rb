require 'spec_helper'

describe BooksHelper do
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
