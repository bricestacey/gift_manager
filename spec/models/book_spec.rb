require 'spec_helper'

describe Book do
  describe 'Validations' do
    it { should_not have_valid(:title).when(nil, '') }
    it { should_not have_valid(:author).when(nil, '') }
  end
end
