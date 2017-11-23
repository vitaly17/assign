class Result
  
# this class will be responsible for technical things such as game setup, status and results 

# creating a method to read given file (containing possible game words & phrases as separate lines) and pushing them into array after stripping new line chars 
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

 def displaymenu
	puts "Menu: (1) Play | (2) New | (3) Analysis | (9) Exit"
end

def get_stats
    file = File.read("stats.txt")
    puts file
end

def show_menu
    displaymenu
    choice = STDIN.gets.chomp
    case choice
    when "1"
        play
    when "2"
        resetgame
        start
    when "3"
        get_stats
        puts "Press 'Enter' to return to the menu"
        STDIN.gets.chomp
        show_menu
        
    when "9"
        exit
    else
        show_menu
    end
end


# creating method to pick a random word from the list of possible game words & phrases. 
# this could be refactured to combine within above method but left as the assignment specification had it.
def gensecretword 
    @wordtable.sample.gsub(/\s+/, "") # revoving all whitespaces as wordfile has phrases as possible secret words
end

def check_status(game) # tracking game status and showing it on screen
    
    puts "Secret word: " + show_word(game.template, game.resulta) # decided to make as a separate method 
    
    puts "Number of errors: #{game.errors}." 
    puts "Letters not in secret word: #{game.resultb.join(', ')}" unless game.resultb.empty?  
    
    
    if game.errors >= 5 
        puts "You have " + (5 - game.errors).to_s + " guesses remaining."
        puts "The game is over. Better luck next time!"
        puts "The secret word was #{game.template.join}."
        outcome = "lost"
        time = Time.now
        @info = "Game finished at #{time} + and was #{outcome}."
        file = File.open("stats.txt", "a+")
        file.puts "\n" + @info
        file.close
        
        
    else
        if game.template.uniq.size == game.resulta.size # checking if the word is guessed in full
      
        puts "Congratulations! You have won the game!"
        outcome = "won"
        time = Time.now
        @info = "Game finished at #{time} + and was #{outcome}."
        file = File.open("stats.txt", "a+")
        file.puts "\n" + @info
        file.close
        show_menu
        else
        puts "You have " + (5 - game.errors).to_s + " guesses remaining."
        end
    end
end

def play

readwordfile("wordfile.txt")

secretword = gensecretword # picking a random word (from the list of possible game words & phrases in wordtable) to be used in the game
game = Game.new(secretword)
game.start
while game.status == 0 do # game loop-will continue while our made-up status is 0 (to denote situation where user still has guesses AND word is not guessed yet)
  check_status(game) # tracking game status and showing it on screen
  game.getguess # getting user input (new letter) + calling another method that will check result
  
end
check_status(game)
show_menu
end


def show_word(template, resulta) # method will show word with guessed and unguessed letters
    result = ""
    for letter in template do # loop to artificially form the word to be shown on screen (forming from guessed letters and underscores)
        if resulta.include?(letter) # checking if letter in secretword is present in guessed letters array
            result += letter + " "
        else
            result += "__ "
        end
    end 
    return result 
end

end