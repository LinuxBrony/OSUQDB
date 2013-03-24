class Vote < ActiveRecord::Base
  belongs_to :quote
  attr_accessible :quote, :upvote
  before_create :check_vote_validity

  validates :quote, {presence: true}
  validates :ip, {presence: true}
  validates :upvote, {inclusion: {in: [true, false]}}

  def change_vote
    recent = Vote.where(quote_id: quote.id, ip: ip).order("created_at DESC").first
    recent.upvote = !recent.upvote
    recent.save
  end

  def check_vote_validity
    if Vote.upvoted?(self.quote.id, self.ip)
      if !self.upvote
        change_vote
      end
      return false
    elsif Vote.downvoted?(self.quote.id, self.ip)
      if self.upvote
        change_vote
      end
      return false
    end
  end

  def self.upvoted?(quote_id, client_ip)
    recent = Vote.where(quote_id: quote_id, ip: client_ip).where("created_at >= ?", 24.hours.ago.utc).first
    unless recent.nil?
      return recent.upvote
    end
    return false
  end

  def self.downvoted?(quote_id, client_ip)
    recent = Vote.where(quote_id: quote_id, ip: client_ip).where("created_at >= ?", 24.hours.ago.utc).first
    unless recent.nil?
      return !recent.upvote
    end
    return false
  end

end
