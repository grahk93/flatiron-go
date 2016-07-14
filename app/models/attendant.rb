class Attendant < ApplicationRecord
  belongs_to :user
  has_many :meetup_attendants
  has_many :meetups, through: :meetup_attendants

  def name
    self.user.name
  end

  def cohort
    self.user.cohort
  end
end
