# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'


# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec

# require "#{File.dirname(__FILE__)}/wad_wof_gen_01" 

# We are not going to use the file above as a part of the working game code. It serves only as an illustration to the basic tests being implemented (passed).
# It is not included in our game code as such as the game logic implementation containing in it was found to be somewhat verbose. 
# It was used as a basis for the code below that was written to reflect the author's own approach and understanding and to implement the game in a perceived 
# OOP way - to this end we divided methods into separate classes Game and Result - those separate files are required below.

require "#{File.dirname(__FILE__)}/game"
require "#{File.dirname(__FILE__)}/results"

# Main program
module WOF_Game
	@input = STDIN
	@output = STDOUT
	filename = "wordfile.txt"

	
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

result.show_menu

result.readwordfile("wordfile.txt")

secretword = result.gensecretword # picking a random word (from the list of possible game words & phrases in wordtable) to be used in the game


 # reading a file that contains list of words & phrases as separate lines and picking a random line for a new game

game = Game.new(secretword)

game.start

while game.status == 0 do # game loop-will continue while our made-up status is 0 (to denote situation where user still has guesses AND word is not guessed yet)
  result.check_status(game) # tracking game status and showing it on screen
  game.getguess # getting user input (new letter) + calling another method that will check result
end

# showing final game result upon exiting game loop in cases where our made up status becomes -1 (to denote lost game) or 1 (to denote won game)
result.check_status(game)

# Any code added to command line game should be added above.
	
		exit	# Does not allow command-line game to run code below relating to web-based version
	end
end

# End modules

# Sinatra routes

# Any code added to web-based game should be added below.

enable	:sessions

# we will be using boolean values for game statuses (:play) in this web version as opposed to our 3 numeric statuses made-up in command line version

get '/play' do
	if session[:play] == true || session[:secretword] == nil 
		redirect to("/new")
	end
	init
	check_status
	erb :play
end

get '/' do
	erb :index
end


get '/won' do
	if session[:template] != session[:resulta]
		redirect to('/lose')
	end 
	init
	session[:play] = true
	erb :won
end

get '/lost' do 
	init
	session[:play] = true
	erb :lost
end

post '/play' do
	check_guess(params["guess"])
	redirect to("/play")
end

get '/new' do
	readwordfile("wordfile.txt")
	session[:secretword] = gensecretword
	session[:template] = setsecretword(session[:secretword])
	session[:resulta] = show_word(session[:secretword])
	session[:resultb] = []
	session[:goes] = 5
	session[:play] = false

	redirect to('/play')
end

helpers do
	
	def init # our own initialise method as we are not using wad_wof_gen_01.rb file that has that method
		@secretword = session[:secretword]
		@template = session[:template]
		@resulta = session[:resulta] 
		@resultb = session[:resultb]
		@goes = session[:goes]
	end
	
def readwordfile(filename) 
@wordtable = []
  if File.exist?(filename)
    file = File.readlines(filename)
    file.each { |word| @wordtable << word.strip }
    return @wordtable
  else
    return nil
  end
end

def gensecretword 
    @wordtable.sample.gsub(/\s+/, "") # removing all whitespaces from the string being picked as the wordfile provided  contains phrases not only single words
end

	def check_status
		if session[:template] == session[:resulta]
			redirect to('/won')
		elsif session[:goes] == 0
			redirect to('/lost')	
		end
	end

	def setsecretword(secretword)
		word = secretword.scan(/./)
		word[0].downcase!
		word
	end

 # the following methods have been re-written (as comparared with our command line version) to simplify things and output logic into main view of our app  

	def show_word(secretword)
		answers = []
		secretword.length.times do
			answers.push("")
		end
		answers
	end

	def check_guess(guess)
		correct = false
		if session[:resultb].include?(guess.downcase) 
			return
		end
		session[:template].each_with_index do |letter,index|
			if guess.downcase == letter 
				session[:resulta][index] = guess.downcase
				correct = true
			end 
		end
		unless correct
			session[:resultb].push(guess.downcase)
			session[:goes] -= 1
		end
	end
end

# Any code added to web-based game should be added above.

# End program