module Hangman
  module Dictionary
    def self.random
      file_data = File.read("linuxwords.txt").split
      
      words = file_data.select{|word| word.length >= 5}
      words.sample
    end
  end
end