require 'rails_helper'

RSpec.describe "Tierlists", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "creating a new tierlist" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link ""
  end
end
