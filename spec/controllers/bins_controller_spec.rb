require 'spec_helper'

describe BinsController do
  describe "GET 'index'" do
    before(:each) do
      @bins = FactoryGirl.create_list(:bin, 25)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :index
      end
      it "assigns @bins" do
        assigns(:bins).should eq(@bins)
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
      @bin = Factory.create(:bin)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :show, id: @bin.id
      end
      it "assigns @bin" do
        assigns(:bin).should eq(@bin)
      end
      it { response.should be_success }
      it { response.should render_template(:show) }
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :show, id: @bin.id }
      end
    end
  end

  describe "GET 'new'" do
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :new
      end
      it "assigns @bin" do
        assigns(:bin).should be_a_new(Bin)
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
      @bin = Factory.create(:bin)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :edit, id: @bin.id
      end
      it "assigns @bin" do
        assigns(:bin).should eq(@bin)
      end
      it { response.should be_success }
      it { response.should render_template(:edit)}
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :edit, id: @bin.id }
      end
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @bin = Factory.build(:bin)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when given valid attributes' do
        before(:each) do
          post :create, bin: FactoryGirl.attributes_for(:bin)
        end
        it { assigns(:bin).should be_a(Bin) }
        it { assigns(:bin).should be_persisted }
        it { response.should redirect_to(assigns(:bin)) }
        it { flash[:success].should eq('You successfully added a bin.') }
      end
      context 'when given invalid attributes' do
        before(:each) do
          Bin.any_instance.stub(:save).and_return(false)
          post :create, bin: FactoryGirl.attributes_for(:bin)
        end
        it { assigns(:bin).should be_a(Bin) }
        it { assigns(:bin).should_not be_persisted }
        it { response.should render_template(:new) }
        it { flash[:error].should eq('There was a problem adding the bin.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { post :create, bin: FactoryGirl.attributes_for(:bin) }
      end
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @bin = Factory.create(:bin)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when given valid attributes' do
        before(:each) do
          put :update, id: @bin.id, bin: FactoryGirl.attributes_for(:bin)
        end
        it { assigns(:bin).should be_a(Bin) }
        it { assigns(:bin).should be_persisted }
        it { response.should redirect_to(assigns(:bin)) }
        it { flash[:success].should eq('You successfully updated the bin.') }
      end
      context 'when given invalid attributes' do
        before(:each) do
          Bin.any_instance.stub(:save).and_return(false)
          put :update, id: @bin.id, bin: FactoryGirl.attributes_for(:bin)
        end
        it { assigns(:bin).should be_a(Bin) }
        it { response.should render_template(:edit) }
        it { flash[:error].should eq('There was a problem updating the bin.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { put :update, id: @bin.id, bin: FactoryGirl.attributes_for(:bin) }
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @bin = Factory.create(:bin)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when all books in the bin have been decided' do
        before(:each) do
          delete :destroy, id: @bin.id
        end
        it { assigns(:bin).should be_a(Bin) }
        it { assigns(:bin).active.should be(false) }
        it { flash[:success].should eq('You successfully archived the bin.') }
      end
      context 'when there are undediced books in the bin' do
        before(:each) do
          @bin.books << Factory.create(:book)
          delete :destroy, id: @bin.id
        end
        it { assigns(:bin).should eq(@bin) }
        it { flash[:error].should eq('You must make a decision on every book before archiving a bin.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { delete :destroy, id: @bin.id }
      end
    end
  end
end
