# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'GET #home' do
    it 'responds successfully' do
      get :home
      expect(response).to be_successful
    end
  end
end
