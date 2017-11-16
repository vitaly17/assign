# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'		

# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec

# require "#{File.dirname(__FILE__)}/wad_wof_gen_01" 

# We are not going to use the file above as a part of the working game code. It serves only as an illustration to the basic tests being implemented (passed).
# It is not included in our game code as such as the game logic implementation containing in it was found to be somewhat verbose. 
# It was used as a basis for the code below that was written to reflect the author's own approach and understanding and to implement the game in a perceived 
# better way.

require "#{File.dirname(__FILE__)}/game"
require "#{File.dirname(__FILE__)}/result"

# Main program
module WOF_Game
	@input = STDIN
	@output = STDOUT
	
	@output.puts 'Enter "1" runs game in command-line window or "2" runs it in web browser.'
	game = @input.gets.chomp
	if game == "1"
		@output.puts "Command line game"
	elsif game == "2"
		@output.puts "Web-based game"
	else
		@output.puts "Invalid input! No game selected."
		exit
	end
		
	if game == "1"

# Any code added to command line game should be added below.
	

# Below is the refactured game code. In a normal application this would go into main app.rb file
  
result = Result.new # creating object of Result class to use it to setup the game, show results and game status

word = result.readwordfile("wordfile.txt") # reading a given file that contains list of words & phrases as separate lines and picking a random line for a new game

game = Game.new(word) # creating instance of Game class and passing a word to it

game.start

while game.status == 0 do # game loop-it will continue while our made up status is 0 (to denote situation where user still has guesses AND word is not guessed yet)
  result.show_status(game) # tracking game status and showing it on screen
  game.getguess # getting user input (new letter) + calling another method that will check result
end

# showing final game result upon exiting game loop in cases where our made up status becomes -1 (to denote lost game) or 1 (to denote won game)
result.show_status(game)

# Any code added to command line game should be added above.
	
		exit	# Does not allow command-line game to run code below relating to web-based version
	end
end

# End modules

# Sinatra routes

# Any code added to web-based game should be added below.


# Any code added to web-based game should be added above.

# End program