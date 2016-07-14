require 'rails_helper'

RSpec.describe User, :type => :model do 
  let(:cohort) {
    Cohort.create(name: "pets_database.db")
  }

  let(:user) {
    User.create(
      name: "Jeff Katz",
      email: "jeffkatz@flatiron.com",
      user_name: "jeffkatz",
      cohort_id: cohort.id,
      password: "jeffrulez"
    )
  }

  #basics
  it "is valid" do 
    expect(user).to be_valid
  end

  it "has a cohort" do 
    expect(user.cohort).to eq(cohort)
  end

  #space for methods

end