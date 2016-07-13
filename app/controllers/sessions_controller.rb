class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new 
    @user = User.new
  end 

  def create
    user = User.find_by(user_name: params[:user][:user_name])
    if user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect_to user_path(session[:user_id])
    else
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

end
