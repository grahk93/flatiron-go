class User < ApplicationRecord
  has_secure_password
  belongs_to :cohort
  has_many :hosts
  has_many :attendants
  accepts_nested_attributes_for :cohort
  def meetups_hosting
  end

  def meetups_attending
  end

  def meetups_attended
  end
end
