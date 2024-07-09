require 'rails_helper'

RSpec.describe "Tierlists", type: :system do

  scenario "creating a new tierlist", js: true do
    user = FactoryBot.create(:user)

    log_in user
    expect(page).to have_content "following"
    visit root_path
    

    expect {
      fill_in "新規Tier listを作成 ...", with: "Test List"
      click_button "新規作成"

      expect(page).to have_content "Tierlist created!"
    }.to change(Tierlist, :count).by(1)
  end

  scenario "guset access to users index" do
    visit users_path
    expect(page).to have_content "Please log in."
  end

  scenario "user delete tierlist" do
    user = FactoryBot.create(:user)
    tierlist = FactoryBot.create(:tierlist, user: user)

    log_in user
    visit root_path

    expect {
      click_link "delete"
      expect(page).to have_content "Tierlist deleted"
    }.to change(Tierlist, :count).by(-1)
  end

end
