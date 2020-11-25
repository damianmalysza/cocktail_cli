require_relative "../config/environment"

class CLIController
  def call
    self.intro_artwork
    puts "Welcome to the Cocktail List of Information, otherwise kwown as 'CLI' ;)"
    puts "Here are some cool things you can do:\n\n"
    self.menu
    puts "Please select from the menu options above using the corresponding number. Type 'quit' to exit: "
    
    input = gets.chomp
    while input != "quit"
      if (1..3).none?(input.to_i)
        puts "You did not enter a valid menu entry. Try again:"
        input = gets.chomp
      else
        case input
          when "1"
            search_by_cocktail
          when "2"
            search_by_ingredient
          when "3"
            random_cocktail
        end
      end
      input = gets.chomp
    end

  end

  def intro_artwork
    puts File.readlines("./lib/cocktail_art.txt") {|line| puts line}
  end

  def menu
    puts "1. Search for cocktail by name"
    puts "2. Search for cocktail by ingredient (e.g. vodka)"
    puts "3. Get information for a random cocktail"
    puts "\n"
  end

  def search_by_cocktail
    puts "searching by cocktail"
  end

  def search_by_ingredient
    puts "searching by ingredient"
  end

  def random_cocktail
    puts "here is a random cocktail"
  end

end