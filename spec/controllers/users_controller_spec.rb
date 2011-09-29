require 'spec_helper'

describe UsersController do
  describe "GET 'index'" do
    before(:each) do
      @users = FactoryGirl.create_list(:user, 25)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :index
      end
      it "assigns @users" do
        assigns(:users).should eq(@users)
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
      @user = Factory.create(:user)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :show, id: @user.id
      end
      it "assigns @user" do
        assigns(:user).should eq(@user)
      end
      it { response.should be_success }
      it { response.should render_template(:show) }
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :show, id: @user.id }
      end
    end
  end

  describe "GET 'new'" do
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :new
      end
      it "assigns @user" do
        assigns(:user).should be_a_new(User)
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
      @user = Factory.create(:user)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :edit, id: @user.id
      end
      it "assigns @user" do
        assigns(:user).should eq(@user)
      end
      it { response.should be_success }
      it { response.should render_template(:edit)}
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :edit, id: @user.id }
      end
    end
  end

  describe "POST 'create'" do
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when given valid attributes' do
        before(:each) do
          post :create, user: FactoryGirl.attributes_for(:user)
        end
        it { assigns(:user).should be_a(User) }
        it { assigns(:user).should be_persisted }
        it { response.should redirect_to(assigns(:user)) }
        it { flash[:notice].should eq('You successfully added a user.') }
      end
      context 'when given invalid attributes' do
        before(:each) do
          User.any_instance.stub(:save).and_return(false)
          post :create, user: FactoryGirl.attributes_for(:user)
        end
        it { assigns(:user).should be_a(User) }
        it { assigns(:user).should_not be_persisted }
        it { response.should render_template(:new) }
        it { flash[:error].should eq('There was a problem adding the user.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { post :create, user: FactoryGirl.attributes_for(:user) }
      end
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = Factory.create(:user)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when given valid attributes' do
        before(:each) do
          put :update, id: @user.id, user: FactoryGirl.attributes_for(:user)
        end
        it { assigns(:user).should be_a(User) }
        it { assigns(:user).should be_persisted }
        it { response.should redirect_to(assigns(:user)) }
        it { flash[:notice].should eq('You successfully updated the user.') }
      end
      context 'when given invalid attributes' do
        before(:each) do
          User.any_instance.stub(:save).and_return(false)
          put :update, id: @user.id, user: FactoryGirl.attributes_for(:user)
        end
        it { assigns(:user).should be_a(User) }
        it { response.should render_template(:edit) }
        it { flash[:error].should eq('There was a problem updating the user.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { put :update, id: @user.id, user: FactoryGirl.attributes_for(:user) }
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @user = Factory.create(:user)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        delete :destroy, id: @user.id
      end
      it { assigns(:user).should be_a(User) }
      it { assigns(:user).should_not be_persisted }
      it { response.should redirect_to(users_path) }
      it { flash[:notice].should eq('You successfully deleted the user.') }
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { delete :destroy, id: @user.id }
      end
    end
  end
end
