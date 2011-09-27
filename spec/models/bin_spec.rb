require 'spec_helper'

describe Bin do
  describe 'attributes' do
    context "given valid attributes" do
      it { should have_valid(:books).when([], [Factory.create(:book)]) }
    context "given invalid attributes" do
      it { should_not have_valid(:name).when(nil, '') }
    end
  end
end
