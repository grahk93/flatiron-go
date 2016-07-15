class Meetup < ApplicationRecord
  belongs_to :host
  has_one :cohort, through: :host
  belongs_to :location
  has_many :meetup_attendants
  has_many :attendants, through: :meetup_attendants
  accepts_nested_attributes_for :location


  def self.today
    #select all meetups where a meetup has today's dates
    Meetup.where("date = ?", Date.today)
  end

  def self.this_week
    #select all meetups where a meetup's current week 
    #is the same as today's current week 
    Meetup.all.select do |m|
      m.date.cweek == Date.today.cweek
    end
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

