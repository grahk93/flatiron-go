class Meetup < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location_id, presence: true
  validate :date_cannot_be_in_the_past


  belongs_to :host
  has_one :cohort, through: :host
  belongs_to :location
  has_many :meetup_attendants
  has_many :attendants, through: :meetup_attendants

  accepts_nested_attributes_for :location

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
      !date.blank? and date < Date.today  
  end

  def today
  end

  def this_week
  end

  def by_location
  end

  def by_host
  end

  def by_cohort
  end

  def pop_location
  end

  def pop_day
  end

  def pop_time
  end 


end 
