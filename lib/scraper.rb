require_relative "../config/environment"

class Scraper

  def get_page
    Nokogiri::HTML(URI.open("https://uk.thebar.com/cocktail-recipes?seeAll=true"))
  end

  def index_cocktails
    self.get_page.css(".recipe-tile").css("a")
  end

  def make_cocktail_objects
    self.index_cocktails.each do |cocktail|
      # iterate through index_cocktails
      # grab the URL, name, and difficulty and instantiate new instances of the drink class
    end
  end

end

Scraper.new.index_cocktails