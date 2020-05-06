class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :item_priorities, :sort_options

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

  def item_priorities
    Rails.application.config.item_priorities.map { |key, value| value }
  end

  def sort_options
    Rails.application.config.sort_options
  end
end
