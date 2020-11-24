require_relative "../config/environment"

class CLIController
  def call
    puts self.intro_artwork
  end

  def intro_artwork
    File.readlines("./lib/cocktail_art.txt") {|line| puts line}
  end

end