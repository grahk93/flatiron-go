class MeetupsController < ApplicationController
  def index 
    @meetups = Meetup.all
  end 

  def new 
    @meetup = Meetup.new
    @days = Date.today..Date.today.advance(days: 6)
  end 
  
  def create 
    @meetup = Meetup.new(meetup_params) #need host to create
    @meetup.host = Host.create(user: current_user)
    @meetup.save
    redirect_to meetup_path(@meetup)
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
    redirect_to meetup_path(@meetup)
  end 

  def destroy
    @meetup = Meetup.find(params[:id])
    @meetup.delete 
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