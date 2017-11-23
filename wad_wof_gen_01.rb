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

def clear_screen
	system "clear" or system "cls"
end


def resetgame
	clear_screen
			@wordtable = []
			@secretword = ""
			@turn = 0
			@resulta = []
			@resultb = []
			@guess = ""
			@template = "[]"
			@winner = 0
			@turnsleft = 0 
end

def readwordfile(filename)
	@wordtable = []
	IO.foreach(filename) { |word| @wordtable.push(word.strip) }
  @wordtable.size
end

def gensecretword
	@wordtable.sample.upcase
end

def getsecretword
	@secretword
end

def setsecretword(secretword)
  @secretword = secretword
  @secretword.split("")
  end

def createtemplate
	@template = ""
	n = @secretword.size
	n.times { @template += "_" }
	"[" + @template + "]"
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