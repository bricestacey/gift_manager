require 'spec_helper'

describe AMZN do
  describe ".find_by_isbn" do
    it "should return the proper price" do
      # VCR strategy is to have a single request on this cassette and have a
      # lenient request match. Otherwise, would need to implement a complicated
      # regular expression.
      VCR.use_cassette 'amzn', match_requests_on: [:method] do
        isbn = '0201853922'
        attributes = AMZN.find_by_isbn(isbn)

        attributes.should eq({
          :price_amazon => '$19.99',
          :thumbnail => 'http://ecx.images-amazon.com/images/I/51C7CVG94XL._SL160_.jpg'
        })
      end
    end
  end
end


