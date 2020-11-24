require_relative "../config/environment"

class Scraper
  include HTTParty

  base_uri 'https://www.thecocktaildb.com/api/json/v1/1/'

  def drink_list_by_name(cocktail)
    response = get("search.php?s=#{name}")

  end

end