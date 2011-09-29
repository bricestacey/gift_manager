class DonorsController < ApplicationController
  respond_to :html

  def index
    @donors = Donor.order(:created_at).page params[:page]

    respond_with @donors
  end

  def new
    @donor = Donor.new

    respond_with @donor
  end

  def show
    @donor = Donor.find(params[:id])

    respond_with @donor
  end

  def edit
    @donor = Donor.find(params[:id])

    respond_with @donor
  end

  def update
    @donor = Donor.find(params[:id])
    @donor.attributes = params[:donor]

    if @donor.save
      redirect_to @donor, :notice => 'You successfully updated the donor.'
    else
      flash.now[:error] = 'There was a problem updating the donor.'
      render :edit
    end
  end

  def create
    @donor = Donor.new(params[:donor])

    if @donor.save
      redirect_to @donor, :notice => 'You successfully added a donor.'
    else
      flash.now[:error] = 'There was a problem adding the donor.'
      render :new
    end
  end

  def destroy
    @donor = Donor.find(params[:id])

    if @donor.books.empty? 
      if @donor.delete
        redirect_to donors_path, :notice => 'You successfully deleted the donor.'
      else
        # There was a problem
      end
    else
      flash[:error] = 'You cannot delete a donor that has donated books. Try removing them first.'
      redirect_to donor_path(@donor)
    end
  end
end
