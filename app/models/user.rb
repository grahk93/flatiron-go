class User < ApplicationRecord
  validates :user_name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, length: { in: 6..20 }, allow_nil: true
  validates :email, presence: true, uniqueness: true, format: { with: /@flatironschool.com/, message: "must be a Flatiron School email" }
  validate :email_valid?
  has_secure_password

  belongs_to :cohort
  has_one :host
  has_many :meetups, through: :host
  has_one :attendant
  has_many :invitations

  def email_valid?
    if email.scan(/@flatironschool.com/).length > 1 || email.scan(/@/).length > 1 || email.end_with?("@flatironschool.com") == false
      errors.add(:email, "is invalid")
    end
  end

  def meetups_hosting
    self.meetups
  end

  def meetups_invited
    self.invitations.to_a.map do |invitation|
      invitation.meetup 
    end
  end

  def meetups_attending
    if self.attendant
      self.attendant.meetups
    else
      []
    end
  end

  def meetups_to_attend #issue with proxy
    self.meetups_attending.select do |meetup|
      meetup.date >= Date.today
    end
  end

  def meetups_attended #issue because all events are ranged starting from today in the seed 
    self.meetups_attending.select do |meetup|
      meetup.date < Date.today
    end
  end

  def is_admin?
    self.admin
  end

end