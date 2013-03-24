class VoteController < ApplicationController
  def create
    quote = Quote.find_by_id(params[:quote_id])
    vote = Vote.new(quote: quote)

    if params[:upvote] == "true"
      vote.upvote = true
    elsif params[:upvote] == "false"
      vote.upvote = false
    end

    vote.ip = request.remote_ip

    if vote.save
      render nothing: true, status: :ok
    else
      render nothing: true, status: 418 #Short and stout
    end
  end

  def update
    quote = Quote.find_by_id(params[:quote_id])
    vote = Vote.where(quote_id: quote.id, ip: request.remote_ip).order("created_at DESC").first

    if params[:upvote] == "true"
      vote.upvote = true
    elsif params[:upvote] == "false"
      vote.upvote = false
    end

    vote.ip = request.remote_ip

    if vote.save
      render nothing: true, status: :ok
    else
      render nothing: true, status: 418 #Short and stout
    end
  end
end
