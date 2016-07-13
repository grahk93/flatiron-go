class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new 
    @user = User.new
  end 

  def create
    user = User.find_by(user_name: user_name_param)
    if user.authenticate(password_param)
      session[:user_id] = user.id 
      redirect_to user_path(session[:user_id])
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_name_param
    params.require(:user).permit(:user_name)[:user_name]
  end

  def password_param
    params.require(:user).permit(:password)[:password]
  end
end
