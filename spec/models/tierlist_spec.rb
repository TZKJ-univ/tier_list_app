require 'rails_helper'

RSpec.describe Tierlist, type: :model do
  
  it "does not allow duplicate tierlist names per user" do
    user = FactoryBot.create(:user)

    user.tierlists.create(
      list: "Tierlist 1"
    )

    new_tierlist = user.tierlists.new(
      list: "Tierlist 1"
    )

    new_tierlist.valid?
    expect(new_tierlist.errors[:list]).to include("has already been taken")
  end

  it "allows two users to share the same tierlist name" do
    user1 = User.create(
      name: "Aaron",
      email: "tester@example.com",
      password: "password",
      password_confirmation: "password"
    )

    user1.tierlists.create(
      list: "Tierlist 1"
    )

    user2 = User.create(
      name: "jon",
      email: "jon@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user2_tierlist = user2.tierlists.new(
      list: "Tierlist 1"
    )

    expect(user2_tierlist).to be_valid
  end
end

describe "create date" do
  it "have a create date" do
    tierlist = FactoryBot.create(:tierlist)
    expect(tierlist.created_at).to_not eq(nil)
  end

  it "does make different create dates" do
    tierlist1 = FactoryBot.create(:tierlist, :created_yesterday)
    tierlist2 = FactoryBot.create(:tierlist, :created_tommorow)
    expect(tierlist1.created_at).to_not eq(tierlist2.created_at)
  end
end
