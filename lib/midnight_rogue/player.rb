class Player
  attr_accessor :energy, :ability, :name

  def initialize(name, energy=generate_energy_status, ability=generate_ability_status)
    @energy = energy.to_i
    @ability = ability.to_i
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
      roll_dice + 6
    end

    def generate_energy_status
      roll_dice + 12
    end
end
