require_relative "test_helper"

class BattleTest < Minitest::Test
  def setup
    @player = Player.new("Player")
    @enemy = Player.new("Enemy")
    @battle = Battle.new(@player, @enemy)
  end
  attr_accessor :player, :enemy, :battle

  def test_should_create_battle
    assert_equal player, battle.me
    assert_equal enemy, battle.enemy
  end

  def test_should_not_create_battle_without_a_player_and_an_enemy
    assert_raises ArgumentError do
      Battle.new
    end

    assert_raises ArgumentError do
      Battle.new player
    end
  end
  
  def test_battle_initial_message
    initial_message = <<~HEREDOC
      ---------------------------
      -       B A T T L E       -
      ---------------------------
    HEREDOC

    output, errors = capture_io do
      battle.battle_initial_message
    end
    assert_equal initial_message, output
    assert_empty errors
  end

  def test_player_should_attack
    player.stubs(:attack).returns(10)
    enemy.stubs(:attack).returns(9)
    enemy_initial_energy = enemy.energy
    damage = 2

    battle.expects(:print_loading)
    battle.expects(:clear_screen)
    battle.expects(:status)

    output, errors = capture_io do
      battle.compute_attacks
    end

    assert_equal (enemy_initial_energy - damage), enemy.energy
    assert_equal "[BATTLE] PLAYER ATTACKED!\n", output
    assert_empty errors
  end

  def test_enemy_should_attack
    enemy.stubs(:attack).returns(10)
    player.stubs(:attack).returns(9)
    player_initial_energy = player.energy
    damage = 2

    battle.expects(:print_loading)
    battle.expects(:clear_screen)
    battle.expects(:status)

    output, errors = capture_io do
      battle.compute_attacks
    end

    assert_equal (player_initial_energy - damage), player.energy
    assert_equal "[BATTLE] ENEMY ATTACKED!\n", output
    assert_empty errors
  end

  def test_player_should_defend
    enemy.stubs(:attack).returns(10)
    player.stubs(:attack).returns(10)
    player_initial_energy = player.energy
    enemy_initial_energy = enemy.energy

    battle.expects(:print_loading)
    battle.expects(:clear_screen)
    battle.expects(:status)

    output, errors = capture_io do
      battle.compute_attacks
    end

    assert_equal player_initial_energy , player.energy
    assert_equal enemy_initial_energy , enemy.energy
    assert_equal "[BATTLE] PLAYER DEFENDED!\n", output
    assert_empty errors
  end

  def test_battle_turn
    battle.expects(:clear_screen)
    battle.expects(:status)
    battle.expects(:compute_attacks)
    battle.expects(:sleep).with(0.5)

    battle.turn
  end

  def test_battle_ending
    battle.enemy.energy = 0
    assert battle.is_over

    battle.enemy.energy = 10
    refute battle.is_over

    battle.me.energy = 0
    assert battle.is_over
  end

  def test_battle_winner
    battle.enemy.energy = 0
    assert_equal player.name, battle.winner

    battle.enemy.energy = 10
    battle.me.energy = 0
    assert_equal enemy.name, battle.winner
  end

  def test_battle_should_not_have_a_winner_if_its_players_are_alive
    assert_equal "THE BATTLE HAS NOT OVER YET!", battle.winner
  end

  def test_display_battle_status
    expected_output =  <<~HEREDOC
      ---------------------------
      -       B A T T L E       -
      ---------------------------
      -------- MY STATUS --------
      | Energy: #{player.energy} | Ability: #{player.ability} |
      ---------------------------

      ------ ENEMY  STATUS ------
      | Energy: #{enemy.energy} | Ability: #{enemy.ability} |
      ---------------------------

    HEREDOC

    output, errors = capture_io do
      battle.status
    end

    assert_equal expected_output, output
    assert_empty errors
  end

  def test_should_print_fighter_status
    energy = 15
    ability = 10
    status = "| Energy: #{energy} | Ability: #{ability} |\n"

    output, errors = capture_io do
      battle.send(:print_fighter_status, energy, ability)
    end
    assert_equal status, output
    assert_empty errors
  end
end