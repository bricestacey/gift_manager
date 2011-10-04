require 'spec_helper'

describe ApplicationHelper do
  describe '#title' do
    context 'given @title is set' do
      before(:each) do
        @title = "Books"
      end
      it "appends Gift Manager to the end" do
        title.should eq("Books | Gift Manager")        
      end
    end
    context 'given @title is not set' do
      it "returns Gift Manager" do
        title.should eq("Gift Manager")
      end
    end
  end

  describe "#breadcrumbs(crumbs)" do
    context 'given home' do
      before(:each) do
        @crumbs = breadcrumbs('Home' => root_path)
      end
      it 'is a link to the root' do
        @crumbs.should include(link_to 'Home', root_path)
      end
    end
    context 'given home and the books path' do
      before(:each) do
        @crumbs = breadcrumbs('Home' => root_path, 'Books' => books_path)
      end
      it 'links to the root path' do
        @crumbs.should include(link_to 'Home', root_path)
      end
      it 'links to the books path' do
        @crumbs.should include(link_to 'Books', books_path)
      end
      it 'has a seperator' do
        @crumbs.should include('/')
      end
    end
  end
end
