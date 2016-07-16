require 'rails_helper'

RSpec.describe User, :type => :model do 
  let(:cohort) { FactoryGirl.create(:cohort) }

  let(:user) { FactoryGirl.create(:user, cohort_id: cohort.id) }

  #basics
  it "is valid" do 
    expect(user).to be_valid
  end

  it "has a cohort" do 
    expect(user.cohort).to eq(cohort)
  end

  #space for methods
  it "can become a host" do
    let(:host) { FactoryGirl.create(:host, user: user)}
    expect(host.user).to eq(user)
  end

  describe "#meetups_hosting" do #works? 
    let (:host) {FactoryGirl.create(:host, user: user)}
    let(:meetup) {FactoryGirl.create(:meetup, host: host)}
    it 'returns the meetups user is hosting' do
      binding.pry
      expect(meetup.host).to eq(host)
    end
  end

  describe "#meetups_hosting" do #this is just wrong
    let (:attendant) {FactoryGirl.create(:attendant, user: user)}
    let(:meetup_attendant) {FactoryGirl.create(:meetup_attendant, attendant: attendant)}
    it 'returns the meetups user attends' do
      expect(meetup.attendants).to eq(attendant)
    end
  end

end
