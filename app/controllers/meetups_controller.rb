class MeetupsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def index 
    @user = current_user
    if params[:search]
      @meetups = Meetup.search(params[:search])
    else
      @meetups = Meetup.all
    end
  end 

  def new 
    @meetup = Meetup.new
    @days = Meetup.date_range
    @times = Meetup.time_range
  end 
  
  def create 
    @meetup = Meetup.new(meetup_params) #need host to create
    @meetup.host = Host.create(user: current_user)
    @meetup.set_time
    @meetup.save#(validate: false)
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

  def join #add current user to current meetup
    @meetup = Meetup.find(params[:id]) #current meetup
    if @meetup.is_host?(current_user)
      flash.now[:join] = 'You cannot join because you are the host!'
      render 'meetups/show'
    elsif @meetup.already_joined?(current_user)
      flash.now[:join] = 'You have already joined this meetup!'
      render 'meetups/show'
    else
      @attendant = Attendant.find_or_create_by(user: current_user) #current attendant/user
      MeetupAttendant.create(meetup: @meetup, attendant: @attendant) #assign meetup to attendant and vice versa
      binding.pry
      invitation = Invitation.find_by(user: current_user)
      Invitation.destroy(invitation.id) if invitation
      flash.now[:join] = 'You joined this meetup!'
      render 'meetups/show'
    end
  end 

  def invite
    @meetup = Meetup.find(params[:id])
    @noninvitees = @meetup.not_invited
  end

  def create_invite
    @meetup = Meetup.find(params[:id])
    invite_params[:invitees].each do |user_id|
      Invitation.create(meetup: @meetup, user_id: user_id)
    end
    redirect_to meetup_path(@meetup)
  end

private

  def meetup_params
    params.require(:meetup).permit(:title, :set_date, :set_hour_min, :location_id, :description)
  end

  def invite_params
    params.permit(invitees: [])
  end
end