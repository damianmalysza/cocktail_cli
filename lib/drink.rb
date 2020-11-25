require_relative "../config/environment"

class Drink
  attr_accessor :name, :ingredients, :difficulty, :instructions, :url


  def initialize(name = nil, difficulty = nil, url = nil)
    @name
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

  def ingredients
    @ingredients = {}
  end

  def instructions
    @instructions = []
  end

end