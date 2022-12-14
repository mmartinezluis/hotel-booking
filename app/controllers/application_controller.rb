class ApplicationController < ActionController::Base
  before_action :current_user, :require_login

  def current_user
    @user = User.find_by(id: session[:user_id])
  end

  def logged_in
    !!session[:user_id]
  end

  def require_login
    unless logged_in
      flash[:msg] = "You must be logged in to perform thsi action"
      redirect_to "/login"
    end
  end

  def redirect_if_logged_in
    if logged_in
      redirect_to hotel_search_path
    end
  end

end
