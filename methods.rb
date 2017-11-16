def get_letters
    slovo = "mallard"
    return slovo.split("")
end

def get_user_input
    letter =""
    while letter == "" do
        letter = STDIN.gets.chomp
    end
    return letter
end

def  check_result(user_input, letters, good_letters, bad_letters)
    
    if(good_letters.include?(user_input) || bad_letters.include?(user_input))
        return 0
    end
    
    if letters.include?(user_input)
        good_letters << user_input
        if letters.uniq.size == good_letters.size #condition that means all the word is guessed correctly and it should return 1 as we pre-aggreed
            return 1
        else
            return 0 #user guessed one letter correctly and goes on
        end
    else
        bad_letters << user_input #if letter is not gueesed correctly it goes into array of letters not present in the word
    end
        return -1 #as pre-agreed in main game file
end

def get_word_for_print(letters, good_letters) # method will show word with guessed and unguessed letters
    result = ""
    for letter in letters do
        if good_letters.include?(letter)
            result += letter + " "
        else
            result += "_ "
        end
    end 
    return result 
end


# method below should show
# 1 the word, if letter unknown then show underscore
# 2 info about errors and used letters
# 3 if errors > 5 then tell about loss and if word is guesses the tell about victory 

def print_status(letters, good_letters, bad_letters, errors) 
    
    puts "Word: " + get_word_for_print(letters, good_letters) # decided to make a separate method above
    
    puts "Number of errors -  #{errors}. Used letters not in word: #{bad_letters.join(', ')}" 
    
    if errors >=5 
        puts "You lost the game"
    else
        if letters.uniq.size == good_letters.size # if the word is guessed in full
        puts "You won!"
        else
        puts "You have " + (5- errors).to_s + " guesses left"
        end
    end
end


