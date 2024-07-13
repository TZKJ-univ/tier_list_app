require 'rails_helper'

RSpec.describe 'Tierlists', type: :request do
  let(:tierlist) { FactoryBot.create(:tierlist) }
  # ユーザーがログインしている場合
  context 'when a user is logged in' do
    before do
      @user = FactoryBot.create(:user)
      log_in_as @user
    end

    context 'with valid attributes' do
      it 'creates a tierlist' do
        tierlist_params = FactoryBot.attributes_for(:tierlist)
        expect do
          post tierlists_path, params: { tierlist: tierlist_params }
        end.to change(Tierlist, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a tierlist' do
        tierlist_params = FactoryBot.attributes_for(:tierlist, :invalid)
        expect do
          post tierlists_path, params: { tierlist: tierlist_params }
        end.to_not change(Tierlist, :count)
      end
    end
  end
end
