class QuotesController < ApplicationController
  def show
    @quote = Quote.find(params[:id])
  end

  def new
    @quote = Quote.new
  end

  def index
    @title = "Browse Quotes"
    @page = get_page_from_params
    @page_count = page_count

    @quotes = Quote.where(approved: true).limit(10).offset((@page - 1) * 10)
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
    @action = 'recent'
    @page = get_page_from_params
    @page_count = page_count

    @quotes = Quote.where(approved: true).order('created_at DESC').limit(10).offset((@page - 1) * 10)

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

  # helper methods
  def get_page_from_params
    if page = params[:page].to_i 
      page = 1 if page <= 0
      page = page_count if page > page_count
    else
      page = 1
    end

    return page
  end

  def page_count
    count = Quote.where(approved: true).count
    if (count / 10 != count / 10.0)
      count = (count / 10) + 1
    end
    return count
  end
end
