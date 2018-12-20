require_relative "lib/midnight_rogue"

# Move this to the right file
trap "SIGINT" do
  exit_game
end

me = Player.new("Mc Champions")
enemy_1 = Player.new("Ednaldo Pereira", 4, 4)
enemy_2 = Player.new("Leonardo Chim", 5, 5)

battle = Battle.new(me, [enemy_1, enemy_2])

until battle.is_over
  battle.turn
end

clear_screen
battle.status
puts "THE BATTLE IS OVER!!"
# puts "The winner is #{battle.winner}"
