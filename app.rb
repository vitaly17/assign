require "./game.rb"
require "./result.rb"

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