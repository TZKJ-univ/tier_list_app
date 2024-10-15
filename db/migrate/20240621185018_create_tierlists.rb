# frozen_string_literal: true

class CreateTierlists < ActiveRecord::Migration[7.0]
  def change
    create_table :tierlists do |t|
      t.string :list
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tierlists, %i[user_id created_at]
  end
end
