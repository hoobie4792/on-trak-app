class AuthController < ApplicationController
  def current_user
    User.find_by(id: session[:user_id])
  end
  
  def login
  end

  def verify
    @user = User.find_by(username: login_params[:username])
    if @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "Shit broke homie"
      redirect_to @login_path
    end
    # if @user
    #   if @user.authenticate(login_params[:password])
    #     session[:user_id] = @user.id
    #     redirect_to user_path(@user)
    #   else
    #     flash[:message] = "Shit broke homie"
    #     redirect_to @login_path
    #   end
    # else
    #   flash[:message] = "Shit broke homie"
    #   redirect_to @login_path
    # end
  end

  private

  def login_params
    params.require(:login).permit(:username, :password)
  end
end