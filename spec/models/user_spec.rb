require 'rails_helper'

RSpec.describe User, :type => :model do 
  let(:cohort) { FactoryGirl.create(:cohort) }
  let(:user) { FactoryGirl.create(:user, cohort_id: cohort.id) }
  let(:admin) { FactoryGirl.create(:user, 
    cohort_id: cohort.id, 
    user_name: "admin", 
    email: 'admin@flatironschool.com', 
    admin: true
  )}

  it "is valid with a cohort, user_name, email, and password" do
    expect(user).to be_valid
  end

  it "is not valid without a password" do
    expect(User.new(user_name: "Name")).not_to be_valid
  end

  it "is not valid without a Flatiron School email" do
    expect(FactoryGirl.build(:user, email: "user@gmail.com")).not_to be_valid
  end

  it "is valid with an admin boolean" do
    expect(admin).to be_valid
  end

  it "defaults to admin => false" do
    expect(user.admin).to eq(false)
  end
 
  it "has a cohort" do 
    expect(user.cohort).to eq(cohort)
  end

  describe "#meetups_hosting" do
    let(:host) { Host.create(user: user) }
    it "can become a host" do
      expect(host.user).to eq(user)
    end
  end

  describe "#meetups_hosting" do
    let(:host) { Host.create(user: user) }
    let(:meetup) { FactoryGirl.create(:meetup, host: host, location: FactoryGirl.create(:location)) }
    it "can host a meetup" do
      expect(meetup.host).to eq(host)
    end
  end

  describe "#meetups_attending" do
    let(:attendant) { Attendant.create(user: user) }
    let(:host) { Host.create(user: FactoryGirl.create(:user, cohort: cohort, email: "host@flatironschool.com", user_name: "host")) }
    let(:meetup) { FactoryGirl.create(:meetup, host: host, location: FactoryGirl.create(:location))}
    let(:meetup_attendant) { MeetupAttendant.create(attendant: attendant, meetup: meetup) }
    it "can attend meetups" do
      expect(meetup_attendant.attendant).to eq(attendant)
      expect(meetup_attendant.meetup).to eq(meetup)
      expect(meetup.attendants.first).to eq(attendant)
    end
  end

end
  
