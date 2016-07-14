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

  # times takes arguments in 0-24 hour increments, 
  # returns 30 minute increments of AM/PM time in strings
  # defaults from 9AM-6PM
  def self.times(range=(9..18))
    range.each_with_object([]) do |time, array|
      if time < 12
        array << "#{time}:00 AM"
        array << "#{time}:30 AM"
      elsif time > 12
        array << "#{time - 12}:00 PM"
        array << "#{time - 12}:30 PM"
      else
        array << "#{time}:00 PM"
        array << "#{time}:30 PM"
      end
    end
  end

  # days returns a number of dates, starting from today,
  # and going forward the number of days provided in the argument.
  # defaults to a week.
  def self.days(num_days=7)
    (Date.today..Date.today.advance(days: (num_days - 1))).to_a
  end

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
      !date.blank? and date < Date.today  
  end

  def today
  end

  def this_week
  end

  def by_cohort
  end

  def by_location
  end

  def by_host
  end

  def pop_location
  end

  def pop_day
  end

  def pop_time
  end 


end 
