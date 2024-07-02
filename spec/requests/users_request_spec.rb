require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    log_in_as(user)
  end

  describe "GET /index" do
    it "responds successfully" do
      get users_path
      expect(response).to be_successful
    end

    it "returns a 200 response" do
      get users_path
      expect(response).to have_http_status "200"
    end
  end
end
