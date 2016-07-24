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
  has_many :invitations
  has_many :users, through: :invitations


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

  def can_attend
    can_attendees = self.cohort.users.to_a
    can_attendees.delete(self.host.user)
    can_attendees
  end

  def is_attending
    self.attendants.to_a.map do |attendee|
      attendee.user 
    end
  end

  def not_attending
    self.can_attend - self.is_attending
  end

  def invitees
    self.users.to_a
  end

  def not_invited
    self.not_attending - self.invitees
  end

  # time methods

  def extract_time
    self.time.to_time.strftime("%I:%M%p")
  end

  def self.date_range(num_days=7, days_ago=0, time_zone='Eastern Time (US & Canada)')
    Time.zone = time_zone
    first_day = Time.zone.parse(days_ago.days.ago.to_s).to_date
    (first_day..(first_day.advance(days: (num_days-1)))).to_a
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
  end

  ## public methods

  def set_time
    if self.time == nil
      date_info = self.set_date.to_date
      time_info = self.set_hour_min.to_time
      self.time = Time.new(
        date_info.year,
        date_info.month, 
        date_info.day, 
        time_info.hour, 
        time_info.min
      ) 
    end
  end

  def get_time
    self.time.to_time
  end

  def date
    self.time.to_date
  end


end 

