class Game
    
  def initialize(slovo) # passing set word
    @secretword = get_secret_word(slovo)
    @errors = 0 
    @good_letters = []
    @bad_letters = []
    @status = 0 # instead of variable result in first version
  end
		
  def get_secret_word(slovo)
    if(slovo == nil || slovo == "")
      abort "No words set" # stoppping loop
    end
    return slovo.downcase.split("")
  end
  
  # this will do the following:
  # 1. ask for a letter
  # 2. check the result
  
  def getguess #get_user_input + check_result
  
  #1. asking for a letter
	#2. checking if it is present in the word
    puts "Please enter a letter "
    guess = ""
    while guess == "" || guess == " " do
      guess = STDIN.gets.chomp
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
  
    if @good_letters.include?(guess) || @bad_letters.include?(guess)
      return # we do not change status if letter is used and the game will continue
    end
    
    if secretword.include?(guess) # if letter is in the word then we will add it to good_letters array
      @good_letters << guess
      
      if @good_letters.size == @secretword.uniq.size # we check if our array of guessed letters is the same as the word set 
      @status = 1
      end
      
    else
      @bad_letters << guess
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
    
    def good_letters
       @good_letters
    end
    
    def bad_letters
       @bad_letters
    end
    
    def status
      @status
    end
    
    def errors
      @errors
    end
    
end