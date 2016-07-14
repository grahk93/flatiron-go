class User < ApplicationRecord
  validates :user_name, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :password, length: { in: 6..20 }, allow_nil: true
  validates :email, presence: true, uniqueness: true, format: { with: /@flatironschool.com/, message: "must be a Flatiron School email" }

  has_secure_password
  belongs_to :cohort
  accepts_nested_attributes_for :cohort
  def meetups_hosting
  end

  def meetups_attending
    #meetup.attendants where attendant id = user id 
    #look at all meetups 
    #look at each meetups attendants 
    #check if the user id matches the attendant id 
    #meetup attendant 
    # MeetupAttendant.attendants.where(attendant_id =current_user.id)

  end

  def meetups_attended
      attendant_ids_of_user = Attendant.where(user_id: current_user.id).pluck(:id)
      attendances_of_user = Attendant.find(attendant_ids_of_user)
      attendances_of_user.collect do |attendance| 
        attendence.meetups
      end


     #Attendant.where(user_id: 187) #finds an attendant by user id
     #Attendant.where(user_id: 187).pluck(:id) #gather the attendant ids of a user (the times they were an attendant)
     #Attendant.find(attendant_ids) #return the attendance times objects

  end
end



def all_attendees
  Attendant.all
# to access ALL meetups and ALL their attendants I need to joing meetus wit meetup attendants 
end

# all_attendees.wnere(current_user.id 5)

# to acces ALL attendants and All their meetups 
# grace.Meetup.joins(:meetup_attendants).where(attendant_id: self.id) --> Meetup.attendants 