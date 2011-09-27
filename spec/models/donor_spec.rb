require 'spec_helper'

describe Donor do
  describe "validations" do
    context "given valid attributes" do
      it { should have_valid(:name) .when('Brice Stacey') }
      it { should have_valid(:phone).when(nil, '', '617-287-5900', '6172875900') }
      it { should have_valid(:email).when(nil, '', 'user@example.com') }
      it { should have_valid(:line1).when(nil, '', 'Healey Library') }
      it { should have_valid(:line2).when(nil, '', '100 Morrissey') }
      it { should have_valid(:city) .when(nil, '', 'Boston') }
      it { should have_valid(:state).when(nil, '', 'MA') }
      it { should have_valid(:zip)  .when(nil, '', '02125') }

      it { should have_valid(:books).when([], [Factory.create(:book)]) }
    end
    context "given invalid attributes" do
      it { should_not have_valid(:name).when(nil, '') }
    end
  end
end
