class LocationsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def index
      @locations = Location.all
  end

  def new
    if current_user.is_admin?
      @location = Location.new
    else
      redirect_to profile_path(session[:user_id])
    end
  end

  def create
    @location = Location.create(name: create_params)
    if @location.valid?
      redirect_to location_path(@location)
    else
      render 'new'
    end
  end

  def show
    @location = Location.find(params[:id])
    @meetups = @location.meetups
  end

  def destroy
    @location = Cohort.find(params[:id])
    @location.delete
  end

  private

  def create_params
    params.require(:location).permit(:name)[:name]
  end
end
