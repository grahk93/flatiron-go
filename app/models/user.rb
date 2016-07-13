class User < ApplicationRecord
  has_secure_password
  #belongs_to :cohort

  def my_meetups 
  end

  def my_cohorts_meetups
  end
end
