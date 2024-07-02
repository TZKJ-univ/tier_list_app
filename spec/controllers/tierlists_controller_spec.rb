require 'rails_helper'

RSpec.describe TierlistsController, type: :controller do

    describe "GET #index" do
        it "responds successfully" do
            get :index
            expect(response).to be_successful
        end
    end

    describe "returns a 200 respinse" do
        it "returns a 200 response" do
            get :index
            expect(response).to have_http_status "200"
        end
    end

end
