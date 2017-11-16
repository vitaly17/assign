class Result
  
# printing game results to the screen and showing game status

def print_status(game) 
    
    puts "Word: " + get_word_for_print(game.secretword, game.good_letters) # decided to make a separate method above
    
    puts "Number of errors -  #{game.errors}. Used letters not in word: #{game.bad_letters.join(', ')}" 
    
    
    if game.errors >=5 
        puts "You lost the game"
    else
        if game.secretword.uniq.size == game.good_letters.size # if the word is guessed in full
      
        puts "Congrats! You won!"
        else
        puts "You have " + (5- game.errors).to_s + " guesses remaining"
        end
    end
end

def get_word_for_print(secretword, good_letters) # method will show word with guessed and unguessed letters
    result = ""
    for letter in secretword do
        if good_letters.include?(letter)
            result += letter + " "
        else
            result += "__ "
        end
    end 
    return result 
end


end