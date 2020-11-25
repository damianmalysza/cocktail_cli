require_relative "../config/environment"

class Drink
  attr_accessor :name, :ingredients, :instructions
  attr_reader :drink_id

  def initialize(name)
    @name = name
    @ingredients = {
      #ingredient1: measurement
      #ingredient2: measurement
    }
    @instructions = nil
  end

  def self.create_from_collection

  end



end