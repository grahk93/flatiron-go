class Meetup < ApplicationRecord
  belongs_to :host
  #belongs_to :location
  has_many :meetup_attendants
  has_many :attendants, through: :meetup_attendants
end
