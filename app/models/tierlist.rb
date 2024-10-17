# frozen_string_literal: true

class Tierlist < ApplicationRecord
  belongs_to :user, optional: true
  has_many :tierlistitems, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :tierlistitems, allow_destroy: true, reject_if: :all_blank
  default_scope -> { order(created_at: :desc) }
  validates :list, presence: true, length: { maximum: 50 },
                   uniqueness: { scope: :user_id }
end
