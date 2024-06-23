class Tierlistitem < ApplicationRecord
  belongs_to :tierlist
  validates :tierlist_id, presence: true
  validates :listitem, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :rank, presence: true
end
