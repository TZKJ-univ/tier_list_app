# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:tierlist) { FactoryBot.create(:tierlist, user:) }
  let(:other_user) { FactoryBot.create(:user) }

  before do
    log_in_as(user)
  end

  describe 'GET /index' do
    it 'responds successfully' do
      get users_path
      expect(response).to be_successful
    end

    it 'returns a 200 response' do
      get users_path
      expect(response).to have_http_status '200'
    end
  end

  describe '#destroy' do
    context 'as an authorized user' do
      it 'deletes a tierlist' do
        log_in_as user
        expect do
          delete tierlist_path(tierlist)
        end.to change(Tierlist, :count).by(-1)
      end
    end

    context 'as an unauthorized user' do
      it 'does not delete the tierlist' do
        log_in_as other_user
        expect do
          delete tierlist_path(tierlist)
        end.to_not change(Tierlist, :count)
      end

      it 'redirect to the root url' do
        log_in_as other_user
        delete tierlist_path(tierlist)
        expect(response).to redirect_to root_url
      end
    end
  end
  describe '#create' do
    context 'as an authorized user' do
      context 'with valid parameters' do
        it 'adds a tierlist' do
          log_in_as user
          expect do
            post tierlists_path, params: { tierlist: { list: 'Test List' } }
          end.to change(Tierlist, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'does not add a tierlist' do
          tierlist_params = FactoryBot.attributes_for(:tierlist, :invalid)
          log_in_as user
          expect do
            post tierlists_path, params: { tierlist: tierlist_params }
          end.to_not change(Tierlist, :count)
        end
      end
    end
  end
end
