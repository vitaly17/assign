require "./game.rb"
require "./result.rb"
require "./word_reader.rb"

result = Result.new

reader = WordReader.new

slovo = reader.read_from_file("wordfile.txt")

game = Game.new(slovo) # creating instance of Game class and passing a word to it

while game.status == 0 do
  result.print_status(game) 
  game.getguess
end

result.print_status(game) 