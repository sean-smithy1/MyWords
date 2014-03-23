class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy, :index]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to MyWords!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    logger.debug "***---- I am here"
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      flash[:error] = "Profile not update"
      render 'edit'
    end
  end

  def destroy
    if current_user == User.find(params[:id])
      flash[:error] = "Sorry, you're unable to delete your own account."
      redirect_to users_path
    else
      User.find(params[:id]).destroy
      flash[:success] = "User and associated lists deleted"
      redirect_to users_path
    end
  end

  def index
     @users = User.paginate(page: params[:page])
  end

private

  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :admin)
  end
end
