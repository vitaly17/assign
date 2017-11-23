require "sinatra"
require "sinatra/reloader" if development?

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