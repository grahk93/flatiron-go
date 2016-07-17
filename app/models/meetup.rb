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

  # search method
  def self.search(search)
    where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%")
  end

  # join/edit methods

  def already_joined?(user)
    self.attendants.pluck('user_id').include?(user.id)
  end

  def is_host?(user)
    self.host.user_id == user.id
  end

  # time methods

  def self.date_range(num_days=7, days_ago=0)
    (((days_ago.days.ago).to_date)..((days_ago.days.ago).to_date.advance(days: (num_days - 1)))).to_a
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

  # fix this
  def self.available?(location_id, date, time)
    if Meetup.where(location_id: location_id, date: date, time: time)[0] == nil
      return [location_id, date, time]
    end
  end

  # queries
  def self.today
    #select all meetups where a meetup has today's dates
    # Meetup.where("date = ?", Date.today)
    Meetup.all.to_a.select do |meetup|
      meetup.date == Date.today
    end
  end

  def self.this_week
    Meetup.all.to_a.select do |m|
      m.date.cweek == Date.today.cweek && m.date >= Date.today
    end
    #should get rid of ones that have already happened this week
  end

  ## public methods

  def set_time
    date_info = self.set_date.to_date
    time_info = self.set_hour_min.to_time
    self.time = Time.new(date_info.year, date_info.month, date_info.day, time_info.hour, time_info.min)
  end

  def get_time
    self.time.to_time
  end

  def date
    self.time.to_date
  end

  ## validation methods

  # private
  
end 

