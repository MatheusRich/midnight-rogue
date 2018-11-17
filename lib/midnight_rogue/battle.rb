class Battle
  attr_accessor :player, :enemy

  def initialize(player, enemy)
    @player = player
    @enemy = enemy
  end

  def battle_initial_message
    puts "---------------------------"
    puts "-       B A T T L E       -"
    puts "---------------------------"
  end

  def compute_attacks
    my_attack = player.attack
    enemy_attack = enemy.attack

    print_loading
    clear_screen
    status

    if my_attack > enemy_attack
      puts "[BATTLE] PLAYER ATTACKED!"
      enemy.energy -= 2
    elsif enemy_attack > my_attack
      puts "[BATTLE] ENEMY ATTACKED!"
      player.energy -= 2
    else
      puts "[BATTLE] PLAYER DEFENDED!"
    end
  end

  def status
    battle_initial_message
    puts "-------- MY STATUS --------"
    print_fighter_status(player.energy, player.ability)
    puts "---------------------------\n"
    puts "\n------ ENEMY  STATUS ------"
    print_fighter_status(enemy.energy, enemy.ability)
    puts "---------------------------\n\n"
  end

  def turn
    clear_screen
    status
    compute_attacks
    sleep 0.5
  end

  def is_over
    player.dead? || enemy.dead?
  end

  def winner
    if self.is_over
      enemy.dead? ? player.name : enemy.name
    else
      "THE BATTLE HAS NOT OVER YET!"
    end
  end

  private
    def print_fighter_status(energy, ability)
      puts "| Energy: #{energy} | Ability: #{ability} |"
    end
end