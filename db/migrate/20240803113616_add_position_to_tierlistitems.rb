# frozen_string_literal: true

class AddPositionToTierlistitems < ActiveRecord::Migration[7.0]
  def change
    add_column :tierlistitems, :position, :integer
  end
end
