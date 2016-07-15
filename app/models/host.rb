class Host < ApplicationRecord
  belongs_to :user
  has_one :cohort, through: :user
  has_many :meetups
  
  def name
    self.user.name
  end

end

