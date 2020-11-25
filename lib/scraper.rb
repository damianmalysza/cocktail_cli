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
      Drink.new(cocktail.css("h3").text, cocktail.css(".item-difficulty").text.strip, cocktail.attr("href"))
    end
  end

end