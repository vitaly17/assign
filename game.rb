# we decided not to use wad_wof_gen_01.rb file in the working version of the game. the base code contained in it has been subject to extensive refactoring 
# and transformed into game.rb and result.rb files
# our working game consists of file to be run - wad_wof_run_01.rb - and 2 class files: game.rb and result.rb that we require in wad_wof_run_01.rb
# wad_wof_gen_01.rb file is attached in its basic version to show that all the rspec tests provided had been passed before the whole game was implemented


class Game 

  # this class will be responsible for main logic of the game and will have all the methods pertaining to game itself

  def initialize(secretword) # passing set word and creating instance variable with initial values
    @template = setsecretword(secretword) # storing set word as array of letters
    @errors = 0  # to store number of incorrect guesses - we will be using this instead of turn variable suggested by base assignment code 
    #the reason is that we will be giving extra guess for each of correct guesses as a suggested inprovement - to make our game more playable
    @resulta = [] # creating array to store used letters that are present in the word
    @resultb = [] # creating array to store used letters that are absent from the word
    @status = 0 # to indicate if the game is still playing or if we need to exit main loop
  end
  
  
  # creating method to convert our secretword (currently being a string) into array of letters to be used in variable called template
  # template variable will represent letters already guessed and underscores in places of unguessed letters
		
  def setsecretword(secretword) 
    if(secretword == nil || secretword == "") # checking if word is set and aborting game if not
      abort "No words set" # stoppping game loop
    end
    return secretword.upcase.split("") # turning word into all capital letters and splitting it into array of letters to be used in variable called template
  end
  

def start
    @myname = "Vitaly Amos"
    @student_id = 51772933
  	puts "Welcome to WOF!"
  	puts "Created by: #{@myname} (#{@student_id})"
  	sleep 1
  	puts "Starting game..."
  	sleep 1
  	puts "In this game you will need to guess the secret word, one letter at a time."
  	sleep 1
  	puts "You have 5 guesses but will be given an extra guess for each letter you guessed correctly." # suggested improvement as it makesgame more playable 
  	puts "You can press 'Enter' any time to return to the menu."
  end
  
  
  def clear_screen
	system "cls" or system "clear"
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

  
  def getguess # asking for and getting user input (letter) + calling method to check result (if the letter entered is present int the word)
  
    puts "Please enter a letter "
    guess = "" # creating local variable to store letters entered by user
    while guess == "" || guess == " " || !guess.match(/\A[a-zA-Z]*\z/) do 
      # loop will continue asking for a correct user input if nothing is entered or empty string received or string contains characters other than letters 
      
      guess = STDIN.gets.chomp.upcase
    end
    check_guess(guess)
  end

  
  def check_guess(guess)
    
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
    
    if template.include?(guess) # if letter is in the word then we will add it to to the list of correctly guessed letters
      @resulta << guess
      
      if @resulta.size == @template.uniq.size # we check if our array of guessed letters is the same as the word set to see if the game is won (finished)
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
    
    def template
       return @template # return keyword can be ommitted in Ruby
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