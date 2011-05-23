require 'spec_helper'

describe Bin do
  describe 'Validations' do
    it { should_not have_valid(:name).when(nil, '') }
  end
end
