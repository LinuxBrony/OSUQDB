class Vote < ActiveRecord::Base
  belongs_to :quote
  attr_accessible :quote, :upvote
  before_save :check_ip

  validates :quote, {presence: true}
  validates :ip, {presence: true}
  validates :upvote, {inclusion: {in: [true, false]}}

  def check_ip
    return Vote.can_vote?(self.quote.id, self.ip)
  end

  def self.can_vote?(quote_id, client_ip)
    recent = Vote.where(quote_id: quote_id, ip: client_ip).order("created_at DESC").first
    unless recent.nil?
      if Time.zone.now - recent.created_at > 86400 
        return true
      else
        return false
      end
    else
      return true
    end
  end
end
