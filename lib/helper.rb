module Helper
  def clear_screen
    system "clear" or system "cls"
  end

  def roll_dice
    rand(1..6)
  end
end