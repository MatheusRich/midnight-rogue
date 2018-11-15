require_relative "lib/midnight_rogue"

me = Player.new("Mc Champions")
enemy = Player.new("Monstro da Rima")
battle = Battle.new(me, enemy)

until battle.is_over
  battle.turn
end

clear_screen
battle.status
puts "THE BATTLE IS OVER!!"
puts "The winner is #{battle.winner}"
