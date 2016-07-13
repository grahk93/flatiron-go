class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create
    @location = Location.create(name: create_params)
  end

  def show
    @location = Location.find(params[:id])
    @meetups = @location.meetups
  end

  def destroy
    @location = Cohort.find(params[:id])
    @location.delete
  end
end
