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
end