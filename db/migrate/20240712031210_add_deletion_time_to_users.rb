# frozen_string_literal: true

class AddDeletionTimeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :deletion_time, :datetime
  end
end
