class StaticPagesController < ApplicationController
   skip_before_action :login_required, only: [:home] #dont do login_required  for the home action


  def home 
  end

end
