class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new 
    @user = User.new
  end 

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
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

private
  def user_params
    params.require(:user).permit(:email, :user_name, :password)
  end

  def edit_user_params
    params.require(:user).permit(:name, :cohort_id, :bio)
  end
end
  # get '/users/new' => 'users#new' #signup 
  # post '/users' => 'users#create'
  # get '/users/:id' => 'users#show'
  # get '/users/:id/edit' => 'users#edit'
  # patch '/users/:id' => 'users#update'