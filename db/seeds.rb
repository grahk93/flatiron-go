# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Attendant.destroy_all
Cohort.destroy_all
Host.destroy_all
Location.destroy_all
Meetup.destroy_all
MeetupAttendant.destroy_all
User.destroy_all

# How many days should it generate from?
num_dates = 7
# What time should meetups start (00-24)
start_times = 9
# What time should meetups end (00-24)
end_times = 19

meetup_days = Meetup.days(num_dates - 1)

meetup_times = Meetup.times(start_times..(end_times - 1))


# create cohorts
6.times do 
  FactoryGirl.create :cohort, name: "#{Faker::Hacker.adjective.capitalize} #{Faker::Team.creature.capitalize}"
end

# create locations
6.times do 
  FactoryGirl.create :location, name: "#{Faker::Name.last_name} Room"
end

locations = Location.all.to_a

# refactor user creation
Cohort.all.each_with_index do |cohort, i1|
  Random.rand(18..24).times do |i2|
    FactoryGirl.create(:user, 
      cohort_id: (cohort.id), 
      name: Faker::Name.name, 
      email: "#{Faker::Internet.user_name(5..12)}#{i1}#{i2}@flatironschool.com", 
      user_name: "#{Faker::Internet.user_name(3..17)}#{i1}#{i2}", 
      password: Faker::Internet.password(6, 20), 
      bio: Faker::Lorem.sentence
    )
  end
end

# def choose_time(meetup_days, meetup_times)
#   date = meetup_days[Random.rand(0..(meetup_days.length - 1))]
#   time = meetup_times[Random.rand(0..(meetup_times.length - 1))]
#   location_id = Random.rand((Location.first.id)..(Location.last.id))

#   if Meetup.available?(location_id, date, time)
#     return [location_id, date, time]
#   else
#     choose_time(meetup_days, meetup_times)
#   end
# end

# Create some meetups and hosts!
Random.rand(9..13).times do |i| 
  FactoryGirl.create( :meetup, 
    title: "#{Faker::Hacker.verb} the #{Faker::Hacker.noun}", 
    description: Faker::Hacker.say_something_smart, 
    host: Host.find_or_create_by(
      user: User.find(
        Random.rand(
          (User.first.id)..(User.last.id))
      )),
    location_id: Random.rand((Location.first.id)..(Location.last.id)),
    date: meetup_days[Random.rand(0..(meetup_days.length - 1))],
    time: meetup_times[Random.rand(0..(meetup_times.length - 1))]
  )
end

# Populate the meetups with attendants
Meetup.all.each do |meetup|
  meetup.host.cohort.users.each do |attendee|
    if Random.rand(0..10) > 7
      MeetupAttendant.create(meetup: meetup, attendant: Attendant.find_or_create_by(user: attendee)) unless attendee == meetup.host.user
    end
  end
end




