class Game 
  
  # this class will be responsible for main logic of the game and will have all the methods pertaining to game itself

  def initialize(word) # passing set word and creating instance variable with initial values
    @secretword = get_secret_word(word) # storing set word as array of letters
    @errors = 0  # to store 
    @resulta = [] # creating array to store used letters that are present in the word
    @resultb = [] # creating array to store used letters that are absent from the word
    @status = 0 # instead of variable result in first version
  end
		
  def get_secret_word(word) # checking if word is set and aborting game if not
    if(word == nil || word == "")
      abort "No words set" # stoppping game loop
    end
    return word.upcase.split("") # turning word into all capital letters and splitting it into array of letters 
  end
  
  def start
    myname = "Vitaly Amos"
    student_id = 51772933
  	puts "Welcome to WOF!"
  	puts "Created by: #{myname} (#{student_id})"
  	sleep 2
  	puts "Starting game..."
  	sleep 2
  	puts "In this game you will need to guess the secret word, one letter at a time."
  	sleep 5
  	puts "You have 5 guesses but will be given an extra guess for each letter you guessed correctly."
  	sleep 5
  	puts "Here comes the secret word!"
  end

  
  def getguess # asking for and getting user input (letter) + calling method to check result (if the letter entered is present int the word)
  
    puts "Please enter a letter "
    guess = "" # creating a local variable to store letters entered by user
    while guess == "" || guess == " " do
      guess = STDIN.gets.chomp.upcase
    end
    next_step(guess)
  end

  
  def next_step(guess)
    
  # this method should do the following:
  # 1. check current status of the game
  # 2. check if the letter has been already used (that is already present in correctly guessed letters or among incorrectly guessed letters)
  # 3. check if the letter is present in the secret word (if yes then add it to the list of correctly guessed letters)
  # 4. check result (see if there are letters to guess or all the word is guessed correctly) and change status accordingly: 
  # to our made up status 1 (to denote won game) or to our made up status -1 (to denote lost game)
    
    if @status == -1 || @status == 1 # checking current status of the game
          return
    end
    
    # checking if the letter has been already used (that is already present in correctly guessed letters or among incorrectly guessed letters)
    if @resulta.include?(guess) || @resultb.include?(guess) 
      puts "This letter has been used. Please choose another one."
      return # we do not change status if letter is used and the game will continue
    end
    
    if secretword.include?(guess) # if letter is in the word then we will add it to to the list of correctly guessed letters
      @resulta << guess
      
      if @resulta.size == @secretword.uniq.size # we check if our array of guessed letters is the same as the word set to see if the game is won (finished)
      @status = 1
      end
      
    else # if the letter is not in secret word then it is added to the list of incorrectly guessed letters and increase errors counter by 1
      @resultb << guess
      @errors += 1
      
      
        if errors >= 5 # if the number of errors reach 5 this will change our made up game status to -1 (to denote lost game)
          @status = -1
        end
    
    end
  end
    
  # creating getter methods to access those instance variables from other classes/places of our code
    
    def secretword
       return @secretword # return keyword can be ommitted in Ruby
    end
    
    def resulta
       @resulta
    end
    
    def resultb
       @resultb
    end
    
    def status
      @status
    end
    
    def errors
      @errors
    end
    
end