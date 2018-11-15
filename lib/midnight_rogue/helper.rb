module Helper
  def clear_screen
    system "clear" or system "cls"
  end

  def roll_dice
    rand(1..6)
  end

  def print_loading(number_of_dots=3)
    number_of_dots.times do 
      print ". "
      sleep 0.25
    end
    clear_screen
  end
end