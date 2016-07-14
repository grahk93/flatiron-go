class MeetupAttendee < ApplicationRecord
  belongs_to :meetup
  belongs_to :attendant
end
