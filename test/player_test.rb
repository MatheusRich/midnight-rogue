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

  def test_should_create_player_with_random_attributes
    my_player = Player.new("Passing just the name")

    assert_equal "Passing just the name", my_player.name
    refute my_player.energy.nil?
    refute my_player.ability.nil?
  end

  def test_player_is_alive
    refute @player.dead?
  end

  def test_player_is_dead
    @player.energy = 0
    assert player.dead?
    @player.energy = -2
    assert player.dead?
  end
end