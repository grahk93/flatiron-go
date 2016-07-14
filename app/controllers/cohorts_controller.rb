class CohortsController < ApplicationController
  
  def index
    @cohorts = Cohort.all
  end

  def new
    @cohort = Cohort.new
  end

  def create
    @cohort = Cohort.create(name: create_params)
    redirect_to cohort_path(@cohort)
  end

  def show
    @cohort = Cohort.find(params[:id])
    @users = @cohort.users
  end

  def destroy
    @cohort = Cohort.find(params[:id])
    @cohort.delete
  end

  private

  def create_params
    params.require(:cohort).permit(:name)[:name]
  end
end
