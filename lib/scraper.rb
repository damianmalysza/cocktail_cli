require_relative "../config/environment"

class Scraper

  def get_page
    Nokogiri::HTML(open("https://uk.thebar.com/cocktail-recipes?seeAll=true"))
  end

end