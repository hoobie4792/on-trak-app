class AuthController < ApplicationController
  
  def login
  end

  def verify
    @user = User.find_by(username: login_params[:username])
    if @user && @user.authenticate(login_params[:password]) && @user.active
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:errors] = ["Login Failed: Try again"]
      redirect_to '/login'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end

  private

  def login_params
    params.require(:login).permit(:username, :password)
  end
end