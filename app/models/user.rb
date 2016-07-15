class User < ApplicationRecord
  validates :user_name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, length: { in: 6..20 }, allow_nil: true
  validates :email, presence: true, uniqueness: true, format: { with: /@flatironschool.com/, message: "must be a Flatiron School email" }
  validate :email_valid?
  has_secure_password

  belongs_to :cohort
  has_many :hosts
  has_many :meetups, through: :hosts
  has_many :attendants
  accepts_nested_attributes_for :cohort

  def email_valid?
    if email.scan(/@flatironschool.com/).length > 1 || email.scan(/@/).length > 1 || email.end_with?("@flatironschool.com") == false
      errors.add(:email, "is invalid")
    end
  end

  def meetups_hosting
    self.meetups
  end

  def meetups_attending
    self.attendants.all.map do |a|
      a.meetups
    end
  end

  def meetups_attended
   puts "hi"
  end
  
end
