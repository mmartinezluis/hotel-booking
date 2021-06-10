class ApplicationController < ActionController::Base

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in
    !!sessions[:user_id]
  end

  def require_login
    unless loggged_in
      flash[:msg] = "You must be logged in to perform thsi action"
      redirec_to login_path
    end
  end

end
