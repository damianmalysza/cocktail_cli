require_relative "../config/environment"

class Drink
  attr_accessor :name, :ingredients, :difficulty, :instructions, :url

  @@all_drinks = []

  def initialize(name = nil, difficulty = nil, url = nil)
    @name = name
    @difficulty = difficulty
    @url = url
    @@all_drinks << self
  end

  def doc
    Nokogiri::HTML(open(self.url))
  end

  def ingredients
    @ingredients = {}
  end

  def instructions
    @instructions = []
  end

  def self.all_drinks
    @@all_drinks
  end

  def present_drink_information_for(drink_object)
    # present difficult for drink
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