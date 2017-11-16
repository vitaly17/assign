class Result
  
# this class will be responsible for technical things such as game setup, status and results 

def readwordfile(filename) # creating a method to read given file  (containing possibel game words & phrases as separate lines) then picking a random line 
  if File.exist?(filename)
    file = File.open(filename, "r")
    lines = file.readlines
    file.close
    return lines.sample.chomp
  else
    return nil
  end
end

def show_status(game) # tracking game status and showing it on screen
    
    puts "Secret word: " + show_word(game.secretword, game.resulta) # decided to make as a separate method 
    
    puts "Number of errors: #{game.errors}. Letters not in word: #{game.resultb.join(', ')}" 
    
    
    if game.errors >= 5 
        puts "You have " + (5 - game.errors).to_s + " guesses remaining."
        puts "The game is over. Better luck next time!"
        puts "The secret word was #{game.secretword.join}."
    else
        if game.secretword.uniq.size == game.resulta.size # checking if the word is guessed in full
      
        puts "Congratulations! You have won the game!"
        else
        puts "You have " + (5 - game.errors).to_s + " guesses remaining."
        end
    end
end

def show_word(secretword, resulta) # method will show word with guessed and unguessed letters
    result = ""
    for letter in secretword do # loop to artificially form the word to be shown on screen (forming from guessed letters and underscores)
        if resulta.include?(letter) # checking if letter in secretword is present in guessed letters array
            result += letter + " "
        else
            result += "__ "
        end
    end 
    return result 
end


end