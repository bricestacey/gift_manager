require 'spec_helper'

describe OCLC do
  use_vcr_cassette 'oclc'
  describe ".attributes_for_isbn" do
    it "should merge the results of .bib_attributes_for_isbn and .location_attributes_for_isbn" do
      isbn = '0201853922'
      attributes = OCLC.attributes_for_isbn(isbn)
      
      attributes.should eq({
        # Attributes from bib_attributes_for_isbn
        title: 'The art of computer programming /',
        author: 'Knuth, Donald Ervin,',
        publisher: 'Upper Saddle River, NJ : Addison-Wesley, 2005-<2006>',
        published: '2005',
        series: '',
        call_number: 'QA76.6 .K64 2005',
        # Attributes from location_attributes_for_isbn
        held_local: true,
        held_remote: 'AUM, BMU, BOS, BXM, MBB, MYG, NED, NHM, SMU, TFW'
      })
    end
  end

  describe ".bib_attributes_for_isbn" do
    it "should return the proper bibliographic attributes" do
      isbn = '0201853922'
      attributes = OCLC.bib_attributes_for_isbn(isbn)

      attributes.should eq({
        title: 'The art of computer programming /',
        author: 'Knuth, Donald Ervin,',
        publisher: 'Upper Saddle River, NJ : Addison-Wesley, 2005-<2006>',
        published: '2005',
        series: '',
        call_number: 'QA76.6 .K64 2005',
      })
    end
  end

  describe ".location_attributes_for_isbn" do
    it "should return the proper holdings information" do
      isbn = '0201853922'
      attributes = OCLC.location_attributes_for_isbn(isbn)

      attributes[:held_local].should eq(true)
      attributes[:held_remote].should eq('AUM, BMU, BOS, BXM, MBB, MYG, NED, NHM, SMU, TFW')
    end
  end
end


