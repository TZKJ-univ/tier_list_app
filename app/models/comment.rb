class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tierlist
  validates :content, presence: true, length: { maximum: 140 }  
end
