# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tierlistitem, type: :model do
  let(:tierlist) { FactoryBot.create(:tierlist) }
  let(:user) { FactoryBot.create(:user) }

  it 'generates associated tierlistitem from a factory' do
    tierlistitem = tierlist.tierlistitems.new(
      listitem: 'Tierlistitem 1',
      rank: 1
    )
    expect(tierlistitem.tierlist).to be_valid
  end

  # it 'does not allow duplicate tierlistitem names per tierlist' do
  #   tierlist.tierlistitems.create(
  #     listitem: 'Tierlistitem 1',
  #     rank: 1
  #   )

  #   new_tierlistitem = tierlist.tierlistitems.new(
  #     listitem: 'Tierlistitem 1',
  #     rank: 2
  #   )

  #   new_tierlistitem.valid?
  #   expect(new_tierlistitem.errors[:listitem]).to include('has already been taken')
  # end
end
