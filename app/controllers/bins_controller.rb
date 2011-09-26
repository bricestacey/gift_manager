class BinsController < ApplicationController
  respond_to :html

  def index
    @bins = Bin.order(:created_at).send(current_scope).page params[:page]

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
      redirect_to @bin, :notice => 'You successfully updated the bin.'
    else
      render :edit
    end
  end

  def create
    @bin = Bin.new(params[:bin])

    if @bin.save
      redirect_to @bin, :notice => 'You successfully added a bin.'
    else
      render :new
    end
  end

  def destroy
    @bin = Bin.find(params[:id])

    # Only archive a bin that has made a recommendation for each book
    if @bin.books.undecided.count == 0
      @bin.active = false

      if @bin.save
        redirect_to bins_path, :notice => 'You successfully archived the bin.'
      else
        redirect_to bins_path, :notice => 'There was a problem archiving the bin. Please try again.'
      end
    else
      flash[:error] = 'You must make a decision on every book before archiving a bin.'
      redirect_to bins_path
    end
  end

  private
  def current_scope
    Bin::SCOPES.include?(params[:scope].try(:to_sym)) ? params[:scope] : 'active'
  end
end
