require 'spec_helper'

describe DonorsController do
  describe "GET 'index'" do
    before(:each) do
      @donors = FactoryGirl.create_list(:donor, 25)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :index
      end
      it "assigns @donors" do
        assigns(:donors).should eq(@donors)
      end
      it { response.should be_success }
      it { response.should render_template(:index) }
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :index }
      end
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @donor = Factory.create(:donor)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :show, id: @donor.id
      end
      it "assigns @donor" do
        assigns(:donor).should eq(@donor)
      end
      it { response.should be_success }
      it { response.should render_template(:show) }
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :show, id: @donor.id }
      end
    end
  end

  describe "GET 'new'" do
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :new
      end
      it "assigns @donor" do
        assigns(:donor).should be_a_new(Donor)
      end
      it { response.should be_success }
      it { response.should render_template(:new) }
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :new }
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @donor = Factory.create(:donor)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :edit, id: @donor.id
      end
      it "assigns @donor" do
        assigns(:donor).should eq(@donor)
      end
      it { response.should be_success }
      it { response.should render_template(:edit)}
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :edit, id: @donor.id }
      end
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @donor = Factory.build(:donor)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when given valid attributes' do
        before(:each) do
          post :create, donor: FactoryGirl.attributes_for(:donor)
        end
        it { assigns(:donor).should be_a(Donor) }
        it { assigns(:donor).should be_persisted }
        it { response.should redirect_to(assigns(:donor)) }
        it { flash[:success].should eq('You successfully added a donor.') }
      end
      context 'when given invalid attributes' do
        before(:each) do
          Donor.any_instance.stub(:save).and_return(false)
          post :create, donor: FactoryGirl.attributes_for(:donor)
        end
        it { assigns(:donor).should be_a(Donor) }
        it { assigns(:donor).should_not be_persisted }
        it { response.should render_template(:new) }
        it { flash[:error].should eq('There was a problem adding the donor.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { post :create, donor: FactoryGirl.attributes_for(:donor) }
      end
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @donor = Factory.create(:donor)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when given valid attributes' do
        before(:each) do
          put :update, id: @donor.id, donor: FactoryGirl.attributes_for(:donor)
        end
        it { assigns(:donor).should be_a(Donor) }
        it { assigns(:donor).should be_persisted }
        it { response.should redirect_to(assigns(:donor)) }
        it { flash[:success].should eq('You successfully updated the donor.') }
      end
      context 'when given invalid attributes' do
        before(:each) do
          Donor.any_instance.stub(:save).and_return(false)
          put :update, id: @donor.id, donor: FactoryGirl.attributes_for(:donor)
        end
        it { assigns(:donor).should be_a(Donor) }
        it { response.should render_template(:edit) }
        it { flash[:error].should eq('There was a problem updating the donor.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { put :update, id: @donor.id, donor: FactoryGirl.attributes_for(:donor) }
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @donor = Factory.create(:donor)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when the donor has no books' do
        before(:each) do
          @donor.books.clear
          delete :destroy, id: @donor.id
        end
        it { assigns(:donor).should be_a(Donor) }
        it { assigns(:donor).should_not be_persisted }
        it { response.should redirect_to(donors_path) }
        it { flash[:success].should eq('You successfully deleted the donor.') }
      end
      context 'when the donor has books' do
        before(:each) do
          @donor.books << Factory.create(:book)
          delete :destroy, id: @donor.id
        end
        it { assigns(:donor).should be_a(Donor) }
        it { assigns(:donor).should be_persisted }
        it { response.should redirect_to(donor_path(@donor)) }
        it { flash[:error].should eq('You cannot delete a donor that has donated books. Try removing them first.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { delete :destroy, id: @donor.id }
      end
    end
  end
end
