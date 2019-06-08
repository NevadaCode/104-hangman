module Hangman
  class Game
    attr_reader :chances, :word, :wrong_tries, :guess, :incorrect_guess

    def initialize
      @chances = 5
      @wrong_tries = 0
      @guess = ""
      @incorrect_guess = []
      @word = Dictionary.random    
    end

    def play
      Graphics.clear_screen
      puts 'Guess this word: ' + Graphics.obfuscate_word(word, '')
     

      while true
        print "[#{chances - wrong_tries} chances left]: "

        char = gets.chomp
        if char == ''
          puts "That's not a letter, silly! Please enter a letter!"
          next
        end
        if !(char =~ /[[:alpha:]]/)
          puts "That's not a letter, silly! Please enter an actual letter!"
          next
        end
        Graphics.clear_screen

        if word.include? char
          if guess.include? char
            puts "You already entered '#{char}'. Yes, it is still correct.. 🙄"
            puts 'Try again: ' + Graphics.obfuscate_word(word, guess)
          else
            guess << char
            placeholder = Graphics.obfuscate_word(word, guess)

            puts 'Whoop Whoop!! ' + placeholder
          end

          unless placeholder.include? Graphics::OBFUSCATION_CHAR
            puts Graphics::ALIVE
            puts "\n\nWELL DONE!! YOU SURVIVED"
            break
          end
        else
          if incorrect_guess.include?(char)
            puts "You already entered '#{char}'. No, it is still NOT correct.. 🙄"
            puts 'Try again: ' + Graphics.obfuscate_word(word, guess)
            next
          end

          puts "OH NOES! The word doesn't contain '#{char}'"
          @wrong_tries = @wrong_tries + 1    
          incorrect_guess.push(char)

          if wrong_tries == chances
            puts Graphics::DEAD
            puts "\nARRRRGGGGGGGGGGG YOU LOST! 😭  😵  ☠️"
            break
          else
            puts 'Try another: ' + Graphics.obfuscate_word(word, guess)
          end
        end
      end
    end
  end
end
