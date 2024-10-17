# frozen_string_literal: true

require 'test_helper'

class TierlistTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @tierlist = @user.tierlists.build(list: 'This is a test tierlist')
  end

  test 'should be valid' do
    assert @tierlist.valid?
  end

  test 'user id can be nil' do
    @tierlist.user_id = nil
    assert @tierlist.valid?
  end

  test 'list should be present' do
    @tierlist.list = '   '
    assert_not @tierlist.valid?
  end

  test 'list should be at most 51 characters' do
    @tierlist.list = 'a' * 51
    assert_not @tierlist.valid?
  end

  test 'order should be most recent first' do
    assert_equal tierlists(:most_recent), Tierlist.first
  end
end
