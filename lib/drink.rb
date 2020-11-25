require_relative "../config/environment"

class Drink
  attr_accessor :name, :difficulty, :url

  @@all_drinks = []

  def initialize(name = nil, difficulty = nil, url = nil)
    @name = name
    @difficulty = difficulty
    @url = url
    self.class.all_drinks << self
  end

  def drink_page
    Nokogiri::HTML(URI.open("https://uk.thebar.com/#{self.url}"))
  end

  def ingredients
    # return a hash of the ingredients
    # hash will have ingredient as keys, and the measurements as values
  end

  def instructions
    # return the order list as a string that you can just puts the ordered list
  end

  def self.all_drinks
    @@all_drinks
  end

  def present_drink_information_for(drink_object)
    # present difficulty for drink
    # present the ingredients for the drink
    # present the instructions for the drink
    # format that in some kind of way
  end

  def self.random_drink_pun
    [
      "Liquor might not solve all your problems, but it's worth a shot!",
      "Why did the drink climb on the bar roof? He heard the next one was on the house!",
      "Why don't they allow dogs in bars? Because mose of them can't hold their licker!",
      "What kind of beer do lumberjacks drink? Loggers!",
      "Take a pitcher - it'll last longer!",
      "My relationship with whiskey is on the rocks.",
      "What do carpenters like to order at the bar? Screwdrivers!"
    ].sample
  end

end

binding.pry