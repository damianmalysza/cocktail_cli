require_relative "../config/environment"

class Drink
  attr_accessor :name, :ingredients, :instructions

  @@potential_ingredients = []

  def initialize(name)
    @name = name
    @ingredients = {}
    @instructions = nil
  end




end