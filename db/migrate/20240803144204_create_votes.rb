class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :tierlistitem, null: false, foreign_key: true
      t.integer :vote_type

      t.timestamps
    end
  end
end
