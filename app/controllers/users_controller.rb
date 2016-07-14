class UsersController < ApplicationController
  helper_method :admin?
  skip_before_action :login_required, only: [:new, :create]
  
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
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end 

  def show 
    if params[:id] == current_user.id.to_s 
      @user = User.find(params[:id])
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
    redirect_to user_path(params[:id])
  end 

  def admin?
    User.find(session[:user_id]).admin
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