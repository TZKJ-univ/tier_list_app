class Tierlistitem < ApplicationRecord
  belongs_to :tierlist
  acts_as_list scope: [:tierlist_id, :rank]
  validates :tierlist_id, presence: true
  validates :listitem, presence: true, length: { maximum: 50 },
                       uniqueness: { scope: :tierlist_id }
  validates :rank, presence: true
  has_many :votes, dependent: :destroy

  # Method to calculate the most frequent vote
  def most_frequent_vote
    vote_counts = votes.group(:vote_type).count
    max_votes = vote_counts.values.max

    # Find the vote type(s) with the maximum count
    frequent_votes = vote_counts.select { |_, count| count == max_votes }.keys

    # Return :stay if there is a tie
    frequent_votes.include?(:stay) ? :stay : frequent_votes.first
  end

  # Method to adjust the rank based on votes
  def adjust_position
    upvotes = votes.where(vote_type: 'up').count
    downvotes = votes.where(vote_type: 'down').count
    stayvotes = votes.where(vote_type: 'stay').count

    if upvotes > downvotes && upvotes > stayvotes
      move_higher
    elsif downvotes > upvotes && downvotes > stayvotes
      move_lower
    end
  end

  private

  # アイテムを上位に移動する
  def move_higher
    self.position -= 1 if position > 1
    save
  end

  # アイテムを下位に移動する
  def move_lower
    self.position += 1
    save
  end
end
