# frozen_string_literal: true

class AddEditableByAnyoneToTierlists < ActiveRecord::Migration[7.0]
  def change
    add_column :tierlists, :editable_by_anyone, :boolean, default: false
  end
end
