# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tierlist, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let!(:tierlist) { FactoryBot.create(:tierlist) }
  let(:tierlist1) { FactoryBot.create(:tierlist, :created_yesterday) }
  let(:tierlist2) { FactoryBot.create(:tierlist, :created_tommorow) }

  it { is_expected.to validate_presence_of(:list) }
  it { is_expected.to validate_uniqueness_of(:list).scoped_to(:user_id) }
  it { is_expected.to validate_length_of(:list).is_at_most(50) }
  it { is_expected.to have_many(:tierlistitems) }

  describe 'create date' do
    it 'have a create date' do
      expect(tierlist.created_at).to_not eq(nil)
    end

    it 'does make different create dates' do
      expect(tierlist1.created_at).to_not eq(tierlist2.created_at)
    end
  end

  describe 'tierlistitem' do
    it 'can have many tierlistitems' do
      tierlist = FactoryBot.create(:tierlist, :with_tierlistitems)
      expect(tierlist.tierlistitems.count).to eq(3)
    end
  end
end
