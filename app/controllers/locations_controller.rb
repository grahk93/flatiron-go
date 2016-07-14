class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    @location = Location.create(name: create_params)
    redirect_to location_path(@location)
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
