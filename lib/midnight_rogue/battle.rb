class Battle
  attr_accessor :player, :enemies

  AVAILABLE_CHOICES =  {
    1 => "Attack",
    2 => "Use Luck"
  }

  def initialize(player, enemies)
    @player = player
    @enemies = enemies
  end

  def battle_initial_message
    puts "---------------------------"
    puts "-       B A T T L E       -"
    puts "---------------------------"
  end

  def compute_attacks
    player_attack = player.attack

    enemies.each_with_index do |enemy, index|
      enemy_attack = enemy.attack
      
      print "\n"
      sleep 1
      print_loading
      clear_screen
      status
      print "\n"

      puts "Player Attack: #{player_attack} | Enemy Attack: #{enemy_attack}\n"
  
      if player_attack > enemy_attack && index == 0
        puts "[BATTLE] PLAYER ATTACKED!"
        enemy.energy -= 2
      elsif enemy_attack > player_attack
        puts "[BATTLE] ENEMY ATTACKED!"
        player.energy -= 2
      else
        puts "[BATTLE] PLAYER DEFENDED!"
      end
    end
  end

  def status
    battle_initial_message
    # puts "-------- #{player.name.upcase}'s STATUS --------"
    puts "-------- MY STATUS --------"
    print_fighter_status(player.energy, player.ability)
    puts "---------------------------\n"
    puts "\n------ " + "ENEMY".pluralize(enemies.count).upcase +  " STATUS ------"
    enemies.each do |enemy| 
      print_fighter_status(enemy.energy, enemy.ability)
    end
    puts "---------------------------\n"
  end

  def display_battle_header
    clear_screen
    status
    display_battle_choices
  end

  def compute_choice(user_choice)
    battle_choice = AVAILABLE_CHOICES[user_choice.to_i]
    
    # FIXME: 
    # I don't think this is the best way to implement this switch case. 
    # Using a string is too unstable, and using just the hash is hard to understand
    case battle_choice
    when "Attack"
     compute_attacks
    when "Use Luck" # TODO
      puts "\n[ MY BAD ] You were unlucky, this feature is not implemented yet!"
      sleep 1
    end
  end
  
  def turn
    display_battle_header
    
    user_choice = get_user_choice(AVAILABLE_CHOICES.keys) do
      display_battle_header
    end

    compute_choice(user_choice)
    
    remove_dead_enemies

    sleep 1
  end

  def is_over
    player.dead? || enemies.all?(&:dead?)
  end

  def winner
    if self.is_over
      enemy.dead? ? player.name : enemy.name
    else
      "THE BATTLE HAS NOT OVER YET!"
    end
  end

  def display_battle_choices
    display_choices(AVAILABLE_CHOICES)
  end
    
  private
    def print_fighter_status(energy, ability)
      puts "| Energy: #{energy} | Ability: #{ability} |"
    end

    def remove_dead_enemies
      enemies.reject!(&:dead?)
    end
end