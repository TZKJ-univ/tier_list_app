class Tierlist < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :list, presence: true, length: { maximum: 50 }, 
                    uniqueness: true
end
