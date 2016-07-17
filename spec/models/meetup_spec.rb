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
    it "returns all meetups scheduled for current day" do
      #class method tests??
    end
  end

  describe ".this_week" do 
    it "returns all meetups scheduled for current week" do
    end
  end
end

