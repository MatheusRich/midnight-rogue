module Helper
  def clear_screen
    system "clear" or system "cls"
  end

  def roll_dice
    rand(1..6)
  end

  def print_loading(number_of_dots=3)
    last_dot = number_of_dots - 1
    number_of_dots.times do |i|
      print "."
      print " " unless i == last_dot
      sleep 0.25
    end
  end



  def get_user_option(valid_options)
    loop do
      puts "[ ? ] What are you going to do?"
      input = STDIN.gets.chomp

      return input if valid_options.include? input
      exit_game if input.downcase == "exit"

      puts "'#{input}' is not a valid option.\n\nTry again:"
    end
  end

  def exit_game
    clear_screen
    exit
  end

end