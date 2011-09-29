class UsersController < ApplicationController
  respond_to :html

  def index
    @users = User.page params[:page]
    
    respond_with @users
  end

  def show
    @user = User.find(params[:id])

    respond_with @user
  end

  def new
    @user = User.new

    respond_with @user
  end

  def edit
    @user = User.find(params[:id])

    respond_with @user
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to @user, :notice => 'You successfully added a user.'
    else
      flash.now[:error] = 'There was a problem adding the user.'
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]

    if @user.save
      redirect_to @user, :notice => 'You successfully updated the user.'
    else
      flash.now[:error] = 'There was a problem updating the user.'
      render :edit
    end

  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path, :notice => 'You successfully deleted the user.'
    else
      flash[:error] = 'There was a problem deleting the user. Please try again.'
      redirect_to users_path
    end
  end
end
