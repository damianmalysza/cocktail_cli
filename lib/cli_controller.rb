class CocktailCli::CLIController

  def call
    CocktailCli::Scraper.new.make_drink_objects
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
            search_by_difficulty
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
    # prompt user to enter search string
    puts "What cocktail are you looking to make?"

    # iterate through Drink class array of instantiated drinks and find ones that have the user string in the name
    # present list of found drinks to user, if none found ask if user wants to try again or return to main menu
    
    cocktail_list = CocktailCli::Drink.find_drinks(gets.chomp)
    if cocktail_list.length == 0
      puts "No drinks found with the name, would you like to try again? (Y/N)"
      search_by_cocktail if gets.chomp.downcase == "y"
    elsif cocktail_list.length == 1
      present_drink_information_for(cocktail_list[0])
    elsif cocktail_list.length > 1
      puts "Multiple drinks found with that name:".colorize(:orange)
      cocktail_list.each.with_index(1) {|drink, indx| puts "#{indx}. #{drink.name}"}
      puts "Enter the number for the drink you would like more information on: "
      present_drink_information_for(cocktail_list[gets.chomp.to_i - 1])
    end
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
    # this method return information for a random object from the all drinks array from the Class object
    # exception handling is needed here as some drinks don't have the secondary information page on the site. 
    # if an error occurs, the method will retry. Low count of these instances so these shouldn't occur a lot.
    begin
      present_drink_information_for(CocktailCli::Drink.all_drinks.sample)
    rescue
      retry
    end
  end

  def present_drink_information_for(drink)
    puts "\n#{drink.name} -- Difficulty: #{drink.difficulty}"
    puts "-------------------------------------------------"
    puts "Ingredients needed:"
    drink.ingredients.each {|ingredient, amount| puts "- #{ingredient}: #{amount}" }
    puts "-------------------------------------------------"
    puts "Instructions for making your drink"
    drink.instructions.each {|instruction| puts instruction}
    nil
  end

end