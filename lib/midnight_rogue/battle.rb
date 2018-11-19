class Battle
  attr_accessor :player, :enemy

  AVAILABLE_CHOICES =  {
    1 => "Attack",
    2 => "Use Luck"
  }

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

    print "\n"
    print_loading
    clear_screen
    status
    print "\n"

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
    puts "---------------------------\n"
  end

  def display_battle_header
    clear_screen
    status
    display_battle_choices
  end

  def compute_turn(user_choice)
    battle_choice = AVAILABLE_CHOICES[user_choice.to_i]
    
    # FIXME: 
    # I don't think this is the best way to implement this switch case. 
    # Using a string is too unstable, and using just the hash is hard to understand
    case battle_choice
    when "Attack"
     compute_attacks
    when "Use Luck" # TODO
      puts "\n[ MY BAD ] You were unlucky, this feature is not implemented yet!"
    end
  end
  
  def turn
    display_battle_header
    
    user_choice = get_user_choice(AVAILABLE_CHOICES.keys) do 
      display_battle_header
    end

    compute_turn(user_choice)

    # continue
    sleep 1
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

  def display_battle_choices
    display_choices(AVAILABLE_CHOICES)
  end
    
  private
    def print_fighter_status(energy, ability)
      puts "| Energy: #{energy} | Ability: #{ability} |"
    end
end