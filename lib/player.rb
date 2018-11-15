class Player
  attr_accessor :energy, :ability, :name

  def initialize(name)
    @energy = generate_energy_status
    @ability = generate_ability_status
    @name = name
  end

  def dead?
    energy <= 0
  end

  def attack
    roll_dice + roll_dice + ability
  end

  private
    def generate_ability_status
      dice = roll_dice
      return dice + 6
    end

    def generate_energy_status
      dice = roll_dice
      return dice + 12
    end
end
