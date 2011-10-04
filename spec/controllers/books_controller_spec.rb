require 'spec_helper'

describe BooksController do
  use_vcr_cassette 'books_controller', match_requests_on: [:method]
  def valid_attributes
    donor = Factory.create(:donor)
    bin   = Factory.create(:bin)
    attributes = FactoryGirl.attributes_for(:book)
    attributes[:donor_id] = donor.id
    attributes[:bin_id] = bin.id
    attributes.delete(:recommendation)
    attributes
  end
  describe "GET 'index'" do
    before(:each) do
      @books = FactoryGirl.create_list(:book, 25)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :index
      end
      it "assigns @books" do
        assigns(:books).should eq(@books)
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
      @book = Factory.create(:book)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :show, id: @book.id
      end
      it "assigns @book" do
        assigns(:book).should eq(@book)
      end
      it { response.should be_success }
      it { response.should render_template(:show) }
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :show, id: @book.id }
      end
    end
  end

  describe "GET 'new'" do
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :new
      end
      it "assigns @book" do
        assigns(:book).should be_a_new(Book)
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
      @book = Factory.create(:book)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
        get :edit, id: @book.id
      end
      it "assigns @book" do
        assigns(:book).should eq(@book)
      end
      it { response.should be_success }
      it { response.should render_template(:edit)}
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { get :edit, id: @book.id }
      end
    end
  end

  describe "POST 'create'" do
    before(:each) do
      @book = Factory.build(:book)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when given valid attributes' do
        before(:each) do
          post :create, book: valid_attributes
        end
        it { assigns(:book).should be_a(Book) }
        it { assigns(:book).should be_persisted }
        it { response.should redirect_to(assigns(:book)) }
        it { flash[:notice].should eq('You successfully added a book.') }
      end
      context 'when given invalid attributes' do
        before(:each) do
          Book.any_instance.stub(:save).and_return(false)
          post :create, book: valid_attributes
        end
        it { assigns(:book).should be_a(Book) }
        it { assigns(:book).should_not be_persisted }
        it { response.should render_template(:new) }
        it { flash.now[:error].should eq('There was a problem adding the book.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { post :create, book: valid_attributes }
      end
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @book = Factory.create(:book)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when given valid attributes' do
        before(:each) do
          put :update, id: @book.id, book: valid_attributes
        end
        it { assigns(:book).should be_a(Book) }
        it { assigns(:book).should be_persisted }
        it { response.should redirect_to(assigns(:book)) }
        it { flash[:notice].should eq('You successfully updated the book.') }
      end
      context 'when given invalid attributes' do
        before(:each) do
          Book.any_instance.stub(:save).and_return(false)
          put :update, id: @book.id, book: valid_attributes
        end
        it { assigns(:book).should be_a(Book) }
        it { response.should render_template(:edit) }
        it { flash[:error].should eq('There was a problem updating the book.') }
      end
      context 'when only updating the recommendation' do
        context 'when updating the recommend to keep' do
          before(:each) do
            put :update, id: @book.id, book: {recommendation: 'keep'}
          end
          it { flash[:notice].should eq("The book's recommendation has been updated to: keep.") }
        end
        context 'when updating the recommend to trash' do
          before(:each) do
            put :update, id: @book.id, book: {recommendation: 'trash'}
          end
          it { flash[:notice].should eq("The book's recommendation has been updated to: trash.") }
        end
        context 'when updating the recommend to undecided' do
          before(:each) do
            put :update, id: @book.id, book: {recommendation: 'undecided'}
          end
          it { flash[:notice].should eq("The book's recommendation has been updated to: undecided.") }
        end
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { put :update, id: @book.id, book: valid_attributes }
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @book = Factory.create(:book)
    end
    context 'when signed in' do
      before(:each) do
        sign_in Factory.create(:user)
      end
      context 'when successful' do
        before(:each) do
          delete :destroy, id: @book.id
        end
        it { assigns(:book).should be_a(Book) }
        it { assigns(:book).should_not be_persisted }
        it { flash[:notice].should eq('You successfully deleted the book.') }
      end
      context 'when unsuccessful' do
        before(:each) do
          Book.any_instance.stub(:destroy).and_return(false)
          delete :destroy, id: @book.id
        end
        it { assigns(:book).should be_persisted }
        it { response.should redirect_to(@book) }
        it { flash[:error].should eq('There was a problem deleting the book.') }
      end
    end
    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { delete :destroy, id: @book.id }
      end
    end
  end
end
