def welcome
  # puts out a welcome message here!
end

def get_character_from_user
  puts "please enter a character"
  user_response = gets.chomp
  user_response.to_s.downcase
  
  # use gets to capture the user's input. This method should return that input, downcased.
end
