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
          puts "Selecting search by name"
          input = gets.chomp
        when "2"
          puts "Selecting search by ingredient"
          input = gets.chomp
        when "3"
          puts "Selecting random"
          input = gets.chomp
        end
      end
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

  

end