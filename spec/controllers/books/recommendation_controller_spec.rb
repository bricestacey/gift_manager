require 'spec_helper'

describe Books::RecommendationController do
  def valid_attributes
    { recommendation: 'keep' }
  end

  describe "PUT 'update'" do
    before(:each) { @book = Factory.create(:book) }

    context 'when signed in' do
      before(:each) { sign_in Factory.create(:user) }

      context 'when given a valid recommendation' do
        before(:each) do
          @recommendation = 'keep'
          put :update, id: @book.id, book: {recommendation: @recommendation}
        end

        it "sets the recommendation" do
          assigns(:book).recommendation.should eq(@recommendation)
        end
        it "sets the flash" do
          flash[:notice].should eq("The book's recommendation has been updated to: #{@recommendation.capitalize}.")
        end
        it "redirects to the book" do
          response.should redirect_to(@book)
        end
      end

      context 'when given an invalid recommendation' do
        before(:each) do
          Book.any_instance.stub(:save).and_return(false)
          put :update, id: @book.id, book: valid_attributes
        end

        it "sets the flash" do
          flash[:error].should eq("There was a problem updating the book's recommendation.")
        end
        it "redirects to the book" do
          response.should redirect_to(@book)
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
end
