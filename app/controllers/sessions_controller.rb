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
    @user = User.find_or_create_by(provider: auth["provider"], uid: auth['uid']) do |u|
      u.email = auth["info"]["email"]
      u.username = auth['info']['name'].downcase.gsub(" ", "_")
      u.password = SecureRandmo.hex(20)
    end
    redirecto_to hotels_path
  end

  def destroy
    session.clear
    redirect_to "/login"
  end

  private
  def auth
    request.env['omniauth.env']
  end

end
