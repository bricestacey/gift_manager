class Donors::BooksController < Books::BaseController
  def find_context
    @donor = Donor.find(params[:donor_id])
    @context = Book.where(:donor_id => @donor.id)
  end
end
