class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    if !session[:user_id].nil? && session[:user_id] != ""
      @user = User.find_by(id: session[:user_id])
    else
      nil
    end
  end

  def logged_in?
    !!current_user
  end
end
