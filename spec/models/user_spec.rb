require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "is valid with a name, email, and password"  do
    user = User.new(
      name: "Aaron",
      email: "tester@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user).to be_valid
  end

  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a duplicate email" do
    User.create(
      name: "Aaron",
      email: "tester@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user = User.new(
      name: "Aaron",
      email: "tester@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
end
