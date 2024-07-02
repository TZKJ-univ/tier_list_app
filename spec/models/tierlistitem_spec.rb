require 'rails_helper'

RSpec.describe Tierlistitem, type: :model do

  it "generates associated tierlistitem from a factory" do
    tierlistitem = FactoryBot.create(:tierlistitem)
    puts "This is the associated #{tierlistitem.tierlist.inspect}"
  end
  
  it "does not allow duplicate tierlistitem names per tierlist" do
    user = User.create(
      name: "Aaron",
      email: "tester@example.com",
      password: "password",
      password_confirmation: "password"
    )

    tierlist = user.tierlists.create(
      list: "Tierlist 1"
    )

    tierlist.tierlistitems.create(
      listitem: "Tierlistitem 1",
      rank: 1
    )

    new_tierlistitem = tierlist.tierlistitems.new(
      listitem: "Tierlistitem 1",
      rank: 2
    )

    new_tierlistitem.valid?
    expect(new_tierlistitem.errors[:listitem]).to include("has already been taken")
  end
end
