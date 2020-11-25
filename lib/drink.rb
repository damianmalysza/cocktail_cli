require_relative "../config/environment"

class Drink
  attr_accessor :name, :ingredients, :instructions, :url


  def initialize(name)
    @name = name
    @ingredients = {
      #ingredient1: measurement
      #ingredient2: measurement
    }
    @instructions = nil
  end

  def doc
    @doc ||= Nokogiri::HTML(open(self.url))
  end

end