require_relative "lib/battle"
require_relative "lib/player"
require_relative "lib/helper"

include Helper

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
