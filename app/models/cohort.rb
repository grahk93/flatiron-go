class Cohort < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :users
  has_many :hosts, through: :users
  has_many :meetups, through: :hosts
  validates_presence_of :name

  def all_meetups
    self.meetups
  end

end
