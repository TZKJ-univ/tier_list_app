class CreateTierlistitems < ActiveRecord::Migration[7.0]
  def change
    create_table :tierlistitems do |t|
      t.references :tierlist, null: false, foreign_key: true
      t.string :listitem
      t.integer :rank

      t.timestamps
    end
    add_index :tierlistitems, [:tierlist_id, :created_at]
  end
end
