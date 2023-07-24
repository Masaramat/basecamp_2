class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

   def update_password
    @user = User.find(params[:id])

    if @user.update(user_password_params)
      redirect_to admin_user_path(@user), notice: 'Password was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully deleted.'
  end

  def make_admin
    @user = User.find(params[:id])
    if @user.admin?
      @user.user!
      redirect_to admin_users_path, notice: "#{@user.firstname} is no longer an admin."
    else
      @user.admin!
      redirect_to admin_users_path, notice: "#{@user.firstname} is now an admin."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def new_user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname)
  end

  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'Access denied.' unless current_user.admin?
  end
end

