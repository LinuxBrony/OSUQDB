class Quote < ActiveRecord::Base
  attr_accessible :body
  has_many :votes

  validates :body, length: {maximum: 1000}, presence: true

  def approve
    self.approved = true
    self.save
  end

  def score
    votes.where(upvote: true).count - votes.where(upvote: false).count
  end
end
