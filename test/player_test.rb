require_relative "test_helper"

class TestHelper < Minitest::Test
  def setup
    @player = Player.new("Awesome Name", 16, 8)
  end
  attr_accessor :player

  def test_should_create_player
    assert_equal "Awesome Name", player.name
    assert_equal 16, player.energy
    assert_equal 8, player.ability
  end

  def test_should_not_create_player_without_name
    assert_raises ArgumentError do
      Player.new
    end
  end

  def test_should_create_player_with_random_attributes_if_they_were_not_provided
    dice_value = 5
    expected_energy = 12 + dice_value
    expected_ability = 6 + dice_value
    Player.any_instance.expects(:roll_dice).twice.returns(dice_value)
    
    name = "Just-the-name"
    my_player = Player.new(name)

    assert_equal name, my_player.name
    assert_equal expected_energy, my_player.energy
    assert_equal expected_ability, my_player.ability
  end

  def test_player_is_alive
    refute player.dead?
  end

  def test_player_is_dead
    player.energy = 0
    assert player.dead?
    player.energy = -2
    assert player.dead?
  end

  def test_player_attack
    player.expects(:roll_dice).twice.returns(5)

    assert_equal (5 + 5 + player.ability), player.attack
  end
end