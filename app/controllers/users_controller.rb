class UsersController < ApplicationController
  skip_before_action :current_user, :require_login, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? 
      @user.save
      session[:user_id] = @user.id
      redirect_to hotels_path
    else
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
