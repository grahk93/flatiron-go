class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def index
    if current_user.is_admin?
      @users = User.all
    elsif session[:user_id] != nil
      redirect_to dashboard_path(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def new 
    @user = User.new
  end 

  def create
    @user = User.new(user_params)
    @cohort = Cohort.find(cohort_params)
    @user.cohort = @cohort
    @user.save
    session[:user_id] = @user.id
    if @user.valid?
      redirect_to profile_path(@user)
    else
      render 'new'
    end
  end 

  def show 
      @user = User.find(params[:id])
  end 

  def profile
    if params[:id] == current_user.id.to_s 
      @user = User.find(params[:id])
      @invites = @user.meetups_invited
    else
      redirect_to profile_path(current_user)
    end
  end

  def edit 
    if params[:id] == current_user.id.to_s 
      @user = User.find(params[:id])
    end
  end 

  def update
    if params[:id] == current_user.id.to_s 
      @user = User.find(params[:id]) 
      @user.update(edit_user_params) 
    end
    redirect_to profile_path(params[:id])
  end 

private
  def user_params
    params.require(:user).permit(:email, :user_name, :password)
  end

  def edit_user_params
    params.require(:user).permit(:name, :cohort_id, :bio)
  end

  def cohort_params
    params.require(:user).permit(:cohort_id)[:cohort_id]
  end
end