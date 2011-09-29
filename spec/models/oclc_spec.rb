require 'spec_helper'

describe OCLC do
  describe ".find_by_isbn" do
    it "should return the proper bibliographic attributes" do
      isbn = '0201853922'
      VCR.use_cassette 'oclc' do
        attributes = OCLC.find_by_isbn(isbn)
        attributes.delete(:held_local)
        attributes.delete(:held_remote)

        attributes.should eq({
          :title => 'The art of computer programming /',
          :author => 'Knuth, Donald Ervin,',
          :publisher => 'Upper Saddle River, NJ : Addison-Wesley, 2005-<2006>',
          :published => '2005',
          :series => '',
          :call_number => 'QA76.6 .K64 2005',
        })
      end
    end

    it "should return the proper holdings information" do
      isbn = '0201853922'
      VCR.use_cassette 'oclc' do
        attributes = OCLC.find_by_isbn(isbn)

        attributes[:held_local].should eq(true)
        attributes[:held_remote].should eq('AUM, BMU, BOS, BXM, MBB, MYG, NED, NHM, SMU, TFW')
      end
    end
  end
end


