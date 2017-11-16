# Ruby code file - All your code should be located between the comments provided.

# Main class module
module WOF_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	GOES = 5

	class Game
		attr_reader :template, :wordtable, :input, :output, :turn, :turnsleft, :winner, :secretword, :played, :score, :resulta, :resultb, :guess
		attr_writer :template, :wordtable, :input, :output, :turn, :turnsleft, :winner, :secretword, :played, :score, :resulta, :resultb, :guess
		
		def initialize(input, output)
			@input = input
			@output = output
			@played = 0
			@score = 0
			@turn = 0
			@wordtable = []
			@secretword = ""
			@resulta = []
			@resultb = []
			@winner = 0
			@guess = ""
			@template = "[]"
		end
		
		def getguess
			guess = @input.gets.chomp.upcase
		end
		
		def storeguess(guess)
			if guess != ""
				@resulta = @resulta.to_a.push "#{guess}"
			end
		end
		
		# Any code/methods aimed at passing the RSpect tests should be added below.
		
def created_by
	@myname = "Vitaly Amos"
	@myname
end

def student_id
	@student_id = 51772933
	@student_id
end

def start
	@output.puts "Welcome to WOF!"
	@output.puts "Created by: #{@myname} (#{@student_id})"
	@output.puts "Starting game..."
	@output.puts 'Enter 1 to run the game in the command-line window or 2 to run it in a web browser'
end

def displaymenu
	@output.puts "Menu: (1) Play | (2) New | (3) Analysis | (9) Exit"
end

def resetgame
end

def readwordfile(filename)
	file = File.readlines(filename)
    file.each { |word| @wordtable << word.strip }
    file.size
end

def gensecretword
end

def setsecretword(value)
	@secretword = value
end

def getsecretword
	@secretword
end

def createtemplate
end

def incrementturn
	@turn += 1
end

def getturnsleft
	@turn += 1
end

def turnsleft
	GOES - 1
end

		# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end


