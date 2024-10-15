# frozen_string_literal: true

class AddVotingAndVisibilityToTierlists < ActiveRecord::Migration[7.0]
  def change
    add_column :tierlists, :votable, :boolean, default: true, null: false
    add_column :tierlists, :public, :boolean, default: true, null: false
  end
end
