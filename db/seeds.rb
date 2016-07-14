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

# create cohorts
6.times do 
  FactoryGirl.create :cohort, name: "#{Faker::Hacker.adjective.capitalize} #{Faker::Team.creature.capitalize}"
end

# create locations
6.times do 
  FactoryGirl.create :location, name: "#{Faker::Name.last_name} Room"
end

# refactor user creation
Cohort.all.each_with_index do |cohort, i1|
  Random.rand(18..24).times do |i2|
    FactoryGirl.create(:user, 
      cohort_id: (cohort.id), 
      name: Faker::Name.name, 
      email: "#{Faker::Internet.user_name(5..12)}#{i1}#{i2}@flatironschool.com", 
      user_name: "#{Faker::Internet.user_name(3..18)}#{i1}#{i2}", 
      password: Faker::Internet.password(6, 20), 
      bio: Faker::Lorem.sentence
    )
  end
end

# Create some meetups and hosts!
Random.rand(10..15).times do 
  FactoryGirl.create( :meetup, 
    title: "#{Faker::Hacker.verb} the #{Faker::Hacker.noun}", 
    description: Faker::Hacker.say_something_smart, 
    host: Host.find_or_create_by(
      user: User.find(
        Random.rand(
          (User.first.id)..(User.last.id))
      )),
    date: Date.today,
    time: Time.now,
    location_id: Random.rand((Location.first.id)..(Location.last.id))
  )
end