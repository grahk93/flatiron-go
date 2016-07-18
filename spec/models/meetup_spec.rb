require 'rails_helper'

RSpec.describe Meetup, :type => :model do 
  let(:cohort) { FactoryGirl.create(:cohort) }
  let(:user) { FactoryGirl.create(:user, cohort: cohort) }
  let(:location) { FactoryGirl.create(:location) }
  let(:meetup) { FactoryGirl.build(:meetup, location: location, host: Host.create(user: user)) }

  #basics
  it "is valid" do 
    expect(meetup).to be_valid
  end

  it "has a location" do 
    expect(meetup.location).to eq(location)
  end

  it "should have host name match user name" do 
    expect(meetup.host.name).to eq(user.name)
  end

  describe ".today" do 
    let(:meetup_today) { FactoryGirl.create(:meetup, location: location, host: Host.create(user: user)) }
    it "returns all meetups scheduled for current day" do
      expect(meetup_today).to eq(Meetup.first)
      expect(Meetup.today[0]).to eq(Meetup.first)
    end
  end
  describe ".this_week" do 
    let(:meetup_tod) { FactoryGirl.create(:meetup, location: location, host: Host.create(user: user)) }
    let(:meetup_tom) { FactoryGirl.create(:meetup, location: location, host: Host.create(user: user), set_date: Date.tomorrow) }
    let(:meetup_eight) {FactoryGirl.create(:meetup, location: location, host: Host.create(user: user), set_date: (Date.today + 8))}
    it "returns all meetups scheduled for current week" do
      expect(meetup_tod).to eq(Meetup.all[0])
      expect(meetup_tom).to eq(Meetup.all[1])
      expect(meetup_eight).to eq(Meetup.all[2])
      expect(Meetup.this_week).to eq([Meetup.all[0], Meetup.all[1]])
    end
  end
end

