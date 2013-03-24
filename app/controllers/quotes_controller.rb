class QuotesController < ApplicationController
  def show
    @quote = Quote.find(params[:id])
  end

  def new
    @quote = Quote.new
  end

  def index
    @title = "Browse Quotes"
    if @page = params[:page].to_i 
      @page -= 1
    else
      @page = 0
    end
    @quotes = Quote.where(approved: true).limit(10).offset(@page * 10)
  end

  def create 
    @quote = Quote.new(body: params[:quote][:body])
    if @quote.save
      redirect_to @quote
    else
      render action: "new"
    end
  end

  def recent
    @title = "Most Recent Quotes"
    if @page = params[:page].to_i 
      @page -= 1
    else
      @page = 0
    end
    @quotes = Quote.where(approved: true).order('created_at DESC').limit(10).offset(@page * 10)

    render :index
  end


  def random
    @title = "Random Quotes"
    if Quote.where(approved: true).count <= 10
      @quotes = Quote.all.shuffle
    else
      @quotes = []
      # TODO: Thing about reworking this part to be more efficient by excluding
      # ids of quotes already in array
      while (@quotes.length < 10) do
        offset = rand(Quote.where(approved: true).count)
        randquote = Quote.where(approved: true).first(offset: offset)
        @quotes << randquote unless @quotes.include? randquote
      end
    end

    render :index
  end
end
