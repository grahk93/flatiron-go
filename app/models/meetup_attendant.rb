class MeetupAttendant < ApplicationRecord
  belongs_to :meetup
  belongs_to :attendant
end
