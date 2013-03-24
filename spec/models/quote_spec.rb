require 'spec_helper'

describe Quote do
  it "should not save an empty quote" do
    quote = Quote.new(body: "")

    quote.save.should_not == true
  end

  it "should not save a quote with just whitespace" do
    quote = Quote.new(body: " \n")

    quote.save.should_not == true
  end

   it "should not save a quote longer than 1000 characters" do
    quote = Quote.new(body: "hurr durr " * 500)

    quote.save.should_not == true
  end

end
