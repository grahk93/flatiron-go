class MeetupsController < ApplicationController
  def index 
    @meetups = Meetup.all
  end 

  def new 
    @meetup = Meetup.new
  end 
  
  def create 
    @meetup = Meetup.create(meetup_params)
  end 

  def show 
    @meetup = Meetup.find(params[:id])
  end 

  def edit  
    @meetup = Meetup.find(params[:id])
  end 

  def update
    @meetup = Meetup.find(params[:id])
    @meetup.update(meetup_params)
  end 

  def destroy
    @meetup = Meetup.find(params[:id])
    @meetup.delete 
  end 

private

  def meetup_params
    params.require(:meetup).permit(:title, :date, :time, :location_id, :description)
  end
end

  # get '/meetups' => 'meetups#index'
  # get '/meetups/new' => 'meetups#new'
  # post '/meetups' => 'meetups#create'
  # get '/meetups/:id' => 'meetups#show'
  # get '/meetups/:id/edit' => 'meetups#edit'
  # patch '/meetups/:id' => 'meetups#update'
  # delete '/meetups/:id' => 'meetups#destroy'