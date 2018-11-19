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

  def display_choices(choices, inicial_index_offset=0)
    puts "\n[ ? ] What are you going to do?\n\n"
    choices.each do |index, choice|
      puts "#{index + inicial_index_offset}\t- #{choice}"
    end
    puts "exit\t- Quit Game"
  end

  def get_user_choice(valid_choices)
    loop do
      print "\nOption: "
      input = STDIN.gets.chomp

      return input if valid_choices.include? input.to_i
      exit_game if input.downcase == "exit"

      yield if block_given? # This is a "hotspot" to display a header

      puts "\n[ HEY YOU! ] '#{input}' is not a valid choice.\n\n"
      puts "Try again:\n"
    end
  end

  def exit_game
    clear_screen
    puts "Cya!"
    exit
  end

  def continue
    print "\n[ Press any key ] "
    STDIN.getch
  end
end