require 'spec_helper'

describe Books::BatchController do
  def valid_attributes
    { recommendation: 'keep' }
  end

  describe "PUT 'update'" do
    before(:each) { @books = FactoryGirl.create_list(:book, 3) }

    context 'when signed in' do
      before(:each) { sign_in Factory.create(:user) }

      context 'when given a valid recommendation' do
        before(:each) do
          @recommendation = 'keep'
          put :update, ids: @books.map(&:id), book: {recommendation: @recommendation}
        end

        it "sets the recommendation" do
          assigns(:books).map(&:recommendation).all? {|r| r == @recommendation}.should be_true
        end
        it "sets the flash" do
          flash[:success].should eq("You have successfully updated the books.")
        end
        it "redirects to the book list" do
          response.should redirect_to(books_path)
        end
      end

      context 'when given an invalid recommendation' do
        before(:each) do
          Book.any_instance.stub(:save!) { raise }
          put :update, ids: @books.map(&:id), book: valid_attributes
        end

        it "sets the flash" do
          flash[:error].should eq("There was a problem changing the books.")
        end
        it "redirects to the book list" do
          response.should redirect_to books_path
        end
      end
    end

    context 'when not signed in' do
      include_context 'a user is not signed in'
      include_examples 'unauthorized access' do
        before(:each) { put :update, ids: @book.id, book: valid_attributes }
      end
    end
  end
end
