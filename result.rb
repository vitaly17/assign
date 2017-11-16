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

# creating method to pick a random word from the list of possible game words & phrases. 
# this could be refactured to combine within above method but left as the assignment specification had it.
def gensecretword 
    @wordtable.sample
end

def show_status(game) # tracking game status and showing it on screen
    
    puts "Secret word: " + show_word(game.template, game.resulta) # decided to make as a separate method 
    
    puts "Number of errors: #{game.errors}. Letters not in secret word: #{game.resultb.join(', ')}" 
    
    
    if game.errors >= 5 
        puts "You have " + (5 - game.errors).to_s + " guesses remaining."
        puts "The game is over. Better luck next time!"
        puts "The secret word was #{game.template.join}."
    else
        if game.template.uniq.size == game.resulta.size # checking if the word is guessed in full
      
        puts "Congratulations! You have won the game!"
        else
        puts "You have " + (5 - game.errors).to_s + " guesses remaining."
        end
    end
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