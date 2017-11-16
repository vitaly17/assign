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
  
  # this will do the following:
  # 1. ask for a letter
  # 2. check the result
  
  def getguess # getting user input (letter) + calling method to check result
  
  #1. asking for a letter
	#2. checking if it is present in the word
    puts "Please enter a letter "
    guess = "" # to store letters chosen by user
    while guess == "" || guess == " " do
      guess = STDIN.gets.chomp.upcase
    end
    next_step(guess)
  end

  
  def next_step(guess)
    
  # this method should do the following:
  # 1. check of the letter entered is present in the given word
  # 2. or if it is in letters already used
  # 3. analogue check_result method in first version
    
    if @status == -1 || @status == 1 #checking current status of the game
      return
    end
  
    if @resulta.include?(guess) || @resultb.include?(guess)
      puts "This letter has been used. Please choose another one."
      return # we do not change status if letter is used and the game will continue
    end
    
    if secretword.include?(guess) # if letter is in the word then we will add it to resulta array
      @resulta << guess
      
      if @resulta.size == @secretword.uniq.size # we check if our array of guessed letters is the same as the word set 
      @status = 1
      end
      
    else
      @resultb << guess
      @errors += 1
      
      
        if errors >= 5
          @status = -1
        end
    
    end
  end
    
  # creating 4 getter methods below to access instance variable from other classes
    
    def secretword
       @secretword #return keyword can be ommotted in Ruby
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