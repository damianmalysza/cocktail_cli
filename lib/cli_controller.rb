require_relative "../config/environment"

class CLIController

  def call
    # initiate instantiation of drinks
    # call the user 
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
    puts "2. Search for cocktail by difficulty"
    puts "3. Get information for a random cocktail"
    puts "\n"
  end

  def search_by_cocktail
    puts "searching by cocktail"
    # prompt user to enter search string
    # iterate through Drink class array of instantiated drinks and find ones that have the user string in the name
    # present list of found drinks to user, if none found ask if user wants to try again or return to main menu
    # user selects the drink that they would like more information on
    # user is presented with the difficulty, ingredients, and instructions
    # user is asked whether they want to search for another cocktail, return to main menu, or quit
  end

  def search_by_difficulty
    puts "searching by difficulty"
    # present the difficulties available by iterating through Drink objects array and collecting array of difficultes, then calling .uniq on it
    # have user select the difficuly they would like to see
    # iterate through Drink object array and collect all Drink names with matching difficulty
    # present the list of drinks to the user
    # have user select the drink that they would like to get more information on
    # user is presented with the difficulty, ingredients, and instructions
    # user is asked whether they want to search for another cocktail, return to main menu, or quit
  end

  def random_cocktail
    puts "here is a random cocktail"
    # Use .sample method on Drink class array to return random Drink object
    # Feed that the present_drink_information_for method
  end

end