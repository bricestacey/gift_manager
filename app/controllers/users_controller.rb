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
      flash[:success] = 'You successfully added a user.'
      redirect_to @user
    else
      flash.now[:error] = 'There was a problem adding the user.'
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    @user.attributes = params[:user]

    if @user.save
      flash[:success] = 'You successfully updated the user.'
      redirect_to @user
    else
      flash.now[:error] = 'There was a problem updating the user.'
      render :edit
    end

  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      flash[:success] = 'You successfully deleted the user.'
      redirect_to users_path
    else
      flash[:error] = 'There was a problem deleting the user.'
      redirect_to @user
    end
  end
end
