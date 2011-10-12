require 'spec_helper'

describe AMZN do
  describe ".attributes_for_isbn" do
    context 'given the Amazon Product API is responding' do
      it "should return the price and thumbnail" do
        # VCR strategy is to have a single request on this cassette and have a
        # lenient request match. Otherwise, would need to implement a complicated
        # regular expression.
        VCR.use_cassette 'amzn', match_requests_on: [:method] do
          isbn = '0201853922'
          attributes = AMZN.attributes_for_isbn(isbn)

          attributes.should eq({
            :price_amazon => '$19.99',
            :thumbnail => 'http://ecx.images-amazon.com/images/I/51C7CVG94XL._SL160_.jpg'
          })
        end
      end
    end
    context 'given the Amazon Product API is not responding' do
      before(:each) do
        Amazon::Ecs.stub(:item_lookup) do
          raise Exception
        end
      end
      it "returns an empty hash" do
        AMZN.attributes_for_isbn('0201853922').should eq({})
      end
    end
  end
end


