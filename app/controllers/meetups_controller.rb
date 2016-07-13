class MeetupsController < ApplicationController
  def index 
    @user = current_user
    @meetups = Meetup.all
  end 

  def new 
    @meetup = Meetup.new
  end 
  
  def create 
    @meetup = Meetup.new(meetup_params) #need host to create
    @meetup.host = Host.create(user: current_user)
    @meetup.save
    redirect_to meetup_path(@meetup)
  end 

  def show 
    @user = current_user
    @meetup = Meetup.find(params[:id])
  end 

  def edit  
    @meetup = Meetup.find(params[:id])
  end 

  def update
    @meetup = Meetup.find(params[:id])
    @meetup.update(meetup_params)
    redirect_to meetup_path(@meetup)
  end 

  def destroy
    @meetup = Meetup.find(params[:id])
    @meetup.delete 
  end 

  def dashboard
    @user = current_user
  end

  def join
     #add current user to current meetup
    @meetup = Meetup.find(params[:id]) #current meetup
    @attendant = Attendant.find_or_create_by(user: current_user) #current attendant/user
    MeetupAttendant.create(meetup: @meetup, attendant: @attendant) #assign meetup to attendant and vice versa
    redirect_to meetup_path(@meetup) #show that meetup
  end 

private

  def meetup_params
    params.require(:meetup).permit(:title, :date, :time, :location_id, :description)
  end

  # def meetup_id 
  #   params.require(:meetup).permit(:id)
  # end
end

  # get '/meetups' => 'meetups#index'
  # get '/meetups/new' => 'meetups#new'
  # post '/meetups' => 'meetups#create'
  # get '/meetups/:id' => 'meetups#show'
  # get '/meetups/:id/edit' => 'meetups#edit'
  # patch '/meetups/:id' => 'meetups#update'
  # delete '/meetups/:id' => 'meetups#destroy'