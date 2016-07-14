class User < ApplicationRecord
  has_secure_password
  belongs_to :cohort
  accepts_nested_attributes_for :cohort
  def meetups_hosting
  end

  def meetups_attending
  end

  def meetups_attended
  end
end
