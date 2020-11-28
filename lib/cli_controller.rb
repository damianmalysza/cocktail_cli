class CocktailCli::CLIController

  @@menu_options = {
    "Search for cocktail by name" => "search_by_cocktail",
    "Get a random cocktail based on difficulty" => "random_cocktail_by_diffculty",
    "Spin the wheel and get a random cocktail" => "random_cocktail"
  }

  def self.menu_options
    @@menu_options
  end

  def present_menu_options
    self.class.menu_options.each.with_index(1) {|(option, method), indx| puts "#{indx}. #{option}"}
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
    self.present_menu_options
    puts self.divider
    puts "Please select the menu option using the corresponding number. Type 'quit' to exit: ".colorize(:green)
    
    input = gets.chomp
    if input.downcase.strip != "quit"
      while input.to_i > self.class.menu_options.length || input.to_i <= 0
        puts "You did not enter a valid menu entry. Try again:".colorize(:green)
        input = gets.chomp
      end
      self.class.menu_options.each.with_index(1) {|(option, method), indx| send("#{method}") if indx == input.to_i }
      puts self.divider
      puts "Would you like to do something else? (Y/N)".colorize(:green)
      input = gets.chomp
      call_user_menu_interaction if input.downcase.strip == "y"
    end
  end

  def search_by_cocktail
    puts "What cocktail are you looking to make?"
    
    cocktail_list = CocktailCli::Drink.find_drinks(gets.chomp)
    if cocktail_list.length == 0
      puts "Oh no - no drinks found with that name!".colorize(:red) + " Would you like to try searching again? (Y/N)".colorize(:green)
      search_by_cocktail if gets.chomp.downcase == "y"
    elsif cocktail_list.length == 1
      present_drink_information_for(cocktail_list[0])
    elsif cocktail_list.length > 1
      puts self.divider
      puts "Multiple drinks found with that name:\n"
      cocktail_list.each.with_index(1) {|drink, indx| puts "#{indx}. #{drink.name}"}
      puts "Enter the number for the drink you would like more information on: ".colorize(:green)
      input = gets.chomp
      while (input.to_i > cocktail_list.length || input.to_i <= 0) && input != "quit"
        puts "Invalid list entry. Please input a valid number on the list above or input 'quit' to return to main menu".colorize(:red)
        input = gets.chomp
      end
      present_drink_information_for(cocktail_list[input.to_i - 1]) unless input.downcase.strip == "quit"
    end

  end

  def random_cocktail_by_diffculty
    puts "Below are the difficulties available:"
    CocktailCli::Drink.difficulties.each.with_index(1) {|difficulty, indx| puts "#{indx} #{difficulty}"}
    puts "Enter the corresponding number for the difficulty you would like to get a cocktail for:".colorize(:green)
    input = gets.chomp
    while (input.to_i > CocktailCli::Drink.difficulties.length || input.to_i <= 0) && input != "quit"
      puts "Invalid entry. Please try again or enter 'quit' to exit".colorize(:red)
      input = get.chomp
    end
    random_cocktail(CocktailCli::Drink.difficulties[input.to_i - 1])
  end

  def random_cocktail(difficulty = nil)
    # this method return information for a random object from the all drinks array from the Class object
    # exception handling is needed here as some drinks don't have the secondary information page on the site. 
    # if an error occurs, the method will retry. Low count of these instances so these shouldn't occur a lot.
    if difficulty == nil
      begin
        present_drink_information_for(CocktailCli::Drink.all_drinks.sample)
      rescue
        retry
      end
    else
      begin
        present_drink_information_for(CocktailCli::Drink.all_drinks.select {|drink| drink.difficulty == difficulty}.sample)
      rescue
        retry
      end
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