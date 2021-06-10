class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to hotels_path
    else
      flash[:msg] = 'Invalid username and/or password'
      render :new
    end
  end

  def logout
    if logged_in
    session.clear
    redirect_to login_path
    end
  end

end
