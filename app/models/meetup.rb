class Meetup < ApplicationRecord
  belongs_to :host
  belongs_to :location
  has_many :attendants
end
