class StaticPagesController < ApplicationController
  skip_before_action :login_required, only: [:home] #dont do login_required  for the home action

  def home 
    if current_user
      redirect_to dashboard_path
    end
  end

end
