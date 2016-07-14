class User < ApplicationRecord
  validates :user_name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, length: { in: 6..20 }, allow_nil: true
  validates :email, presence: true, uniqueness: true, format: { with: /@flatironschool.com/, message: "must be a Flatiron School email" }

  has_secure_password
  belongs_to :cohort
  has_one :attendant
  has_one :host
  accepts_nested_attributes_for :cohort
  
  def meetups_hosting
  end

  def meetups_attending
  end

  def meetups_attended
  end
end
