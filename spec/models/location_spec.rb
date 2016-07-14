require 'rails_helper'

RSpec.describe Location, :type => :model do 
  let(:location) { FactoryGirl.create(:location) }

  #basics
  it "is valid" do 
    expect(location).to be_valid
  end
end