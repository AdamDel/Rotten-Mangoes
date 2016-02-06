class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def redirect_if_not_admin
   unless current_user && is_admin?
     redirect_to movies_path 
     flash[:alert] = "You are trying to access an admin page, you dont have those rights!"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def nil_session
    session[:user_id] = nil
  end


  def is_admin?
    current_user.admin if session[:user_id]  #checks if user is admin if the user is logged in 
  end
  helper_method :current_user, :is_admin?
  
end
