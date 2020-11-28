class CocktailCli::Drink
  attr_accessor :name, :difficulty, :url

  @@all_drinks = []

  @@difficulties = []

  def initialize(name = nil, difficulty = nil, url = nil)
    @name = name
    @difficulty = difficulty
    @url = url
    self.class.all_drinks << self
    self.class.difficulties << difficulty unless self.class.difficulties.include?(difficulty)
  end

  def drink_page
    Nokogiri::HTML(URI.open("https://uk.thebar.com/#{self.url}"))
    # TODO: do not instantiate objects if get a runtime error on attempting to load URL
  end

  def ingredients
    Hash.new.tap do |return_hash|
      drink_page.css(".ingredients .instruction-item-list li").css(":not(.instruction-item-list-units)").each do |ingredient|
        # on each iteration added a new hash key named as ingredient with value set as the quantity of ingredient and unit of ingredient, unless the ingredient name is blank
        return_hash[ingredient.css(".instruction-item-list-detail").text.strip] = "#{ingredient.css(".instruction-item-list-quantity span").attr("data-initialvalue")} #{ingredient.css(".instruction-item-list-quantity span").attr("data-unit")}" unless ingredient.css(".instruction-item-list-detail").text.strip == ""
      end
    end
  end

  def instructions
    drink_page.css(".method-list li p").collect.with_index(1) do |instruction, indx|
      "#{indx}. #{instruction.text}" unless instruction.text == nil
    end
    #TODO: fix printing blank instructions (some pages don't have p element but use div).
  end

  def self.all_drinks
    @@all_drinks
  end

  def self.difficulties
    @@difficulties
  end

  def self.find_drinks(search_term)
    self.all_drinks.select do |drink|
      drink.name.downcase.include?(search_term.downcase)
    end
    #returns array of drink objects whose name includes the search term
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