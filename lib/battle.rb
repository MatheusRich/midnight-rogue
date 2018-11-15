class Battle
  attr_accessor :me, :enemy

  def initialize(me, enemy)
    @me = me
    @enemy = enemy
    
    battle_initial_message
  end

  def battle_initial_message
    puts "---------------------------"
    puts "-       B A T T L E       -"
    puts "---------------------------"
  end

  def compute_attacks
    my_attack = me.attack
    enemy_attack = enemy.attack

    if my_attack > enemy_attack
      puts "[BATTLE] PLAYER ATTACKED!"
      enemy.energy -= 2
    elsif enemy_attack > my_attack
      puts "[BATTLE] ENEMY ATTACKED!"
      me.energy -= 2
    else
      puts "[BATTLE] PLAYER DEFENDED!"
    end
  end

  def status
    puts "\n***************************"
    puts "######## MY STATUS ########"
    print_status(me.energy, me.ability)
    
    puts "\n###### ENEMY  STATUS ######"
    print_status(enemy.energy, enemy.ability)
    puts "***************************\n"
  end

  def turn
    clear_screen
    battle_initial_message
    compute_attacks
    status
    sleep 0.75
  end

  def is_over
    me.dead? || enemy.dead?
  end

  def winner
    if self.is_over
      enemy.dead? ? me.name : enemy.name
    else
      "THE BATTLE HAS NOT OVER YET!"
    end
  end

  private
    def print_status(energy, ability)
      puts "- Energy: #{energy}"
      puts "- Ability: #{ability}"
    end
end