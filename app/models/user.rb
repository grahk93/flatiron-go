class User < ApplicationRecord
  has_secure_password
  belongs_to :cohort
  accepts_nested_attributes_for :cohort
end
