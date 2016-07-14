require 'rails_helper'

RSpec.describe Cohort, :type => :model do 
  let(:cohort) { FactoryGirl.create(:cohort) }

  #basics
  it "is valid" do 
    expect(cohort).to be_valid
  end

end