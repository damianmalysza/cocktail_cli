require_relative "../config/environment"

class Scraper
  include HTTParty
  base_uri 'https://www.thecocktaildb.com/api/json/v1/1'

  def self.drink_list_by_name(cocktail)
    response = get("/search.php?s=#{cocktail}")
    drink_array = response["drinks"]
    if drink_array != nil
      drink_array.each.with_index(1) do |drink, indx|
        puts "#{indx}: #{drink["strDrink"]}"
      end
    end
  end

end