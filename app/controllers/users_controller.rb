class UsersController < ApplicationController
  def new 
    @user = User.new
  end 

  def create
    @user = User.create(user_params)
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def edit 
    @user = User.find(params[:id])
  end 

  def update
    @user = User.find(params[:id]) 
    @user.update(user_params) #might need dif params here 
  end 

private
  def user_params
    params.require(:user).permit(:email, :user_name, :password)
  end
end
  # get '/users/new' => 'users#new' #signup 
  # post '/users' => 'users#create'
  # get '/users/:id' => 'users#show'
  # get '/users/:id/edit' => 'users#edit'
  # patch '/users/:id' => 'users#update'