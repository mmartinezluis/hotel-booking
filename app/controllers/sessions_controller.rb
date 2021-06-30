class SessionsController < ApplicationController
  skip_before_action :require_login, :current_user
  before_action :redirect_if_logged_in, only: [:new]

  def new

  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to hotels_path
    else
      flash[:msg] = 'Invalid email and/or password'
      render :new
    end
  end

  def omniauth
    @user = User.from_omniauth(auth)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to hotel_search_path
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to "/login"
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
