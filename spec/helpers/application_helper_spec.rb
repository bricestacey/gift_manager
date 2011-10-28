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
end
