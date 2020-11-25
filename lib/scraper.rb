require_relative "../config/environment"

class Scraper

  def get_page
    Nokogiri::HTML(open("https://uk.thebar.com/cocktail-recipes?seeAll=true"))
  end

  def index_cocktails
    self.get_page.css(".recipe-tile")
  end

  def make_cocktail_objects

  end

end