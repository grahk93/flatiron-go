# Have these methods be feature driven - I think that will lead them to be more complicated.  
# Maybe narrow down the scope of the application to drive features.

class Meetup < ApplicationRecord
  before_validation :set_time
  attr_accessor :set_date, :set_hour_min
  validates :title, presence: true
  validates :description, presence: true
  validates :time, presence: true
  validates :location_id, presence: true


  belongs_to :host
  has_one :cohort, through: :host
  belongs_to :location
  has_many :meetup_attendants
  has_many :attendants, through: :meetup_attendants

  accepts_nested_attributes_for :location

  ## class methods

  # time methods I need to replace

  def self.date_range(num_days=7)
    (Date.today..Date.today.advance(days: (num_days - 1))).to_a
  end

  def self.time_range(range=(9..18))
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

  # queries
  def self.today
  end

  def self.this_week
  end

  def self.by_location
  end

  def self.by_host
  end

  def self.by_cohort
  end

  ## public methods

  def set_time
    date_info = self.set_date.to_date
    time_info = self.set_hour_min.to_time
    self.time = Time.new(date_info.year, date_info.month, date_info.day, time_info.hour, time_info.min)
  end

  def time
    self.time.to_time
  end

  def date
    self.time.to_date
  end

  ## validation methods

  # private
  
end 
