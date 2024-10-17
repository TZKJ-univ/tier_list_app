# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tierlists', type: :system do
  scenario 'creating a new tierlist', js: true do
    user = FactoryBot.create(:user)

    log_in user
    visit root_path

    # expect do
    #   fill_in '新規ティアリストを作成 ...', with: 'Test List'
    #   click_button '新規作成'

    #   expect(page).to have_content 'Tierlist created!'
    # end.to change(Tierlist, :count).by(1)
  end

  scenario 'guset access to users index' do
    visit users_path
    expect(page).to have_content 'Please log in.'
  end
end
