class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :update_access, :total_votes

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = 'Must be logged in for that action'
      redirect_to root_path
    end
  end

  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end

  def access_denied
    flash[:error] = "You do not have access to that action"
    redirect_to root_path
  end

  def update_access(obj)
    obj.creator == current_user
  end

  def total_votes(obj)
    plus_votes(obj) - minus_votes(obj)
  end

  def plus_votes(obj)
    obj.votes.where(vote: true).count
  end

  def minus_votes(obj)
    obj.votes.where(vote: false).count
  end
end
