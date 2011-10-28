class BinsController < ApplicationController
  respond_to :html

  def index
    @bins = Bin.order(:created_at).page params[:page]
    if params[:active]
      @bins = @bins.where(active: params[:active] == "true")
    else
      @bins = @bins.where(active: true)
    end

    respond_with @bins
  end

  def show
    @bin = Bin.find(params[:id])
    @books = @bin.books

    respond_with @bin, @books
  end

  def new
    @bin = Bin.new

    respond_with @bin
  end

  def edit
    @bin = Bin.find(params[:id])

    respond_with @bin
  end

  def update
    @bin = Bin.find(params[:id])
    @bin.attributes = params[:bin]

    if @bin.save
      flash[:success] = 'You successfully updated the bin.'
      redirect_to @bin
    else
      flash.now[:error] = 'There was a problem updating the bin.'
      render :edit
    end
  end

  def create
    @bin = Bin.new(params[:bin])

    if @bin.save
      flash[:success] = 'You successfully added a bin.'
      redirect_to @bin
    else
      flash.now[:error] = 'There was a problem adding the bin.'
      render :new
    end
  end

  def destroy
    @bin = Bin.find(params[:id])
    @bin.active = false

    if @bin.save
      flash[:success] = 'You successfully archived the bin.'
      redirect_to bins_path
    else
      flash[:error] = 'You must make a decision on every book before archiving a bin.'
      redirect_to bins_path
    end
  end
end
