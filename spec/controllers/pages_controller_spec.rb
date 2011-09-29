require 'spec_helper'

describe PagesController do
  describe "GET 'home'" do
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get 'home'
      end
      it { response.should be_success }
      it { response.should render_template(:home) }
      it { assigns(:counts).should be_a(Hash) }
      it { assigns(:counts).should include(:today, :today_undecided, :today_keep, :today_trash) }
      it { assigns(:counts).should include(:total, :total_undecided, :total_keep, :total_trash) }
    end
  end
end
