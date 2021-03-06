require_relative "lib/midnight_rogue"

# Move this to the right file
trap "SIGINT" do
  exit_game
end

me = Player.new("Mc Champions")
enemy = Player.new("Leonardo Chim")
battle = Battle.new(me, enemy)

until battle.is_over
  battle.turn
end

clear_screen
battle.status
puts "THE BATTLE IS OVER!!"
puts "The winner is #{battle.winner}"
