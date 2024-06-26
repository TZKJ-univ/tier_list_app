class Tierlist < ApplicationRecord
  belongs_to :user
  has_many :tierlistitems, dependent: :destroy
  accepts_nested_attributes_for :tierlistitems, allow_destroy: true, reject_if: :all_blank
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :list, presence: true, length: { maximum: 50 }, 
                    uniqueness: true
end