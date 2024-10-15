# frozen_string_literal: true

class ChangeUserIdToBeOptionalInTierlists < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tierlists, :user_id, true
  end
end
