class User < ApplicationRecord
  has_secure_password
  #belongs_to :cohort

  def meetups_hosting
  end

  def meetups_attending
  end

  def meetups_attended
  end
  
end
