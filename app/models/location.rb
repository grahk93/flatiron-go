class Location < ApplicationRecord
  has_many :meetups
  validates_presence_of :name
end
