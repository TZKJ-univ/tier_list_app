# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TierlistsController, type: :controller do
  describe 'GET #index' do
    it 'responds successfully' do
      get :index
      aggregate_failures do
        expect(response).to be_successful
        expect(response).to have_http_status '200'
      end
    end
  end
end
