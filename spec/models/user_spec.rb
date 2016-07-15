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
end