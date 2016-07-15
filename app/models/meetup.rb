# Have these methods be feature driven - I think that will lead them to be more complicated.  
# Maybe narrow down the scope of the application to drive features.

class Meetup < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location_id, presence: true
  validate :date_cannot_be_in_the_past
  validate :time_must_be_available


  belongs_to :host
  has_one :cohort, through: :host
  belongs_to :location
  has_many :meetup_attendants
  has_many :attendants, through: :meetup_attendants

  accepts_nested_attributes_for :location

  ## class methods

  # time methods
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

  def self.days(num_days=7)
    (Date.today..Date.today.advance(days: (num_days - 1))).to_a
  end


  def self.available?(location_id, date, time)
    if Meetup.where(location_id: location_id, date: date, time: time)[0] == nil
      return [location_id, date, time]
    end
  end

  # queries
  def self.today
    #select all meetups where a meetup has today's dates
    Meetup.where("date = ?", Date.today)
  end

  def self.this_week
    Meetup.all.select do |m|
      m.date.cweek == Date.today.cweek && m.date > Date.today
    end
    #should get rid of ones that have already happened this week
  end

  ## public methods
  def available?
    Meetup.where(location: location, date: date, time: time)[0] == nil
  end

  ## validation methods

  private
  
  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
      !date.blank? and date < Date.today  
  end

  def time_must_be_available
    errors.add(:time, "must be available") if 
      Meetup.where(location: location, date: date, time: time)[0] != nil
  end

end 

