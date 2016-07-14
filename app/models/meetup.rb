class Meetup < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location_id, presence: true
  validate :date_cannot_be_in_the_past


  belongs_to :host
  #belongs_to :location
  has_many :meetup_attendants
  has_many :attendants, through: :meetup_attendants

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
      !date.blank? and date < Date.today  
  end
  
end
