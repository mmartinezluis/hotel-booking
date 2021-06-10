class UsersController < ApplicationController
#   validates_presence_of :username, :email, :password, on: [:create]

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
