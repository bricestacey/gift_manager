require 'spec_helper'

describe Book do
  describe 'validations' do
    context "given valid attributes" do
      it { should have_valid(:isbn).when(nil, '', '1234567890') }
      it { should have_valid(:title).when('Walden Pond') }
      it { should have_valid(:author).when('Thoreau') }
      it { should have_valid(:published).when(nil, '', '2011') }
      it { should have_valid(:publisher).when(nil, '', 'UMass Boston') }
      it { should have_valid(:series).when(nil, '', '1') }
      it { should have_valid(:call_number).when(nil, '', 'QA76.6 .K64 1997') }
      it { should have_valid(:held_local).when(nil, true, false) }
      it { should have_valid(:held_remote).when(nil, 'BMU, AAA, CCC') }
      it { should have_valid(:price_amazon).when(nil, '', '$19.00') }
      it { should have_valid(:thumbnail).when(nil, '', 'http://example.com/thumbnail.jpg') }
      it { should have_valid(:recommendation).when('undecided', 'keep', 'trash', 'sell', 'sell') }

      it { should have_valid(:donor).when(Factory.create(:donor)) }
      it { should have_valid(:bin).when(Factory.create(:bin)) }
    end

    context "given invalid attributes" do
      it { should_not have_valid(:title).when(nil, '') }
      it { should_not have_valid(:author).when(nil, '') }
      it { should_not have_valid(:donor).when(nil) }
      it { should_not have_valid(:donor_id).when(nil) }
      it { should_not have_valid(:bin).when(nil) }
      it { should_not have_valid(:bin_id).when(nil) }
      it { should_not have_valid(:recommendation).when(nil, '') }
    end
  end
end
