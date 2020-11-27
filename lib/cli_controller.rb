class CocktailCli::CLIController

  @@menu_options = {
    "Search for cocktail by name" => "search_by_cocktail",
    "Search for cocktail by difficulty" => "search_by_difficulty",
    "Get information for random cocktail" => "random_cocktail"
  }

  def self.menu_options
    @@menu_options
  end

  def call
    CocktailCli::Scraper.new.make_drink_objects
    self.user_initial_greeting
    self.call_user_menu_interaction
    self.goodbye_messsage
  end

  def intro_artwork
    File.readlines("./lib/cocktail_art.txt") {|line| puts line}
  end

  def user_initial_greeting
    puts self.intro_artwork
    puts "Welcome to the Cocktail List of Information, otherwise kwown as 'CLI' ;)"
  end

  def call_user_menu_interaction
    puts self.divider
    puts "Menu Options:"
    self.class.menu_options.each.with_index(1) {|(option, method), indx| puts "#{indx}. #{option}"}
    puts self.divider
    puts "Please select the menu option using the corresponding number. Type 'quit' to exit: "
    
    input = gets.chomp
    if input.downcase.strip != "quit"
      while input.to_i > self.class.menu_options.length || input.to_i <= 0
        puts "You did not enter a valid menu entry. Try again:"
        input = gets.chomp
      end
      self.class.menu_options.each.with_index(1) {|(option, method), indx| send("#{method}") if indx == input.to_i }
      call_user_menu_interaction
    end
  end

  def search_by_cocktail
    # prompt user to enter search string
    puts "What cocktail are you looking to make?"

    # iterate through Drink class array of instantiated drinks and find ones that have the user string in the name
    # present list of found drinks to user, if none found ask if user wants to try again or return to main menu
    
    cocktail_list = CocktailCli::Drink.find_drinks(gets.chomp)
    if cocktail_list.length == 0
      puts "Oh no - no drinks found with that name!".colorize(:red) + " Would you like to try searching again? (Y/N)".colorize(:green)
      search_by_cocktail if gets.chomp.downcase == "y"
    elsif cocktail_list.length == 1
      present_drink_information_for(cocktail_list[0])
    elsif cocktail_list.length > 1
      puts self.divider
      puts "Multiple drinks found with that name:\n".colorize(:orange)
      cocktail_list.each.with_index(1) {|drink, indx| puts "#{indx}. #{drink.name}"}
      puts "Enter the number for the drink you would like more information on: "
      input = gets.chomp
      while (input.to_i > cocktail_list.length || input.to_i <= 0) && input != "quit"
        puts "Invalid list entry. Please input a valid number on the list above or input 'quit' to return to main menu"
        input = gets.chomp
      end
      present_drink_information_for(cocktail_list[input.to_i - 1]) unless input.downcase.strip == "quit"
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
    puts self.divider
    puts "Ingredients needed:"
    begin
      drink.ingredients.each {|ingredient, amount| puts "- #{ingredient}: #{amount}" }
    rescue
      puts "Uh oh - ingredients for this drink currently unavailable :(".colorize(:red)
    end
    puts self.divider
    puts "Instructions for making your drink"
    begin
      drink.instructions.each {|instruction| puts instruction}
    rescue
      puts "Uh oh - instructions for this drink currently unavailable :(".colorize(:red)
    end
  end

  def goodbye_messsage
    puts self.divider
    puts "Thanks for using the CLI! Here's a pun to enjoy while sipping on your drink: #{CocktailCli::Drink.random_drink_pun}"
    puts "Cheers!"
  end

  def divider
    "=========================================================================================================================================="
  end
end