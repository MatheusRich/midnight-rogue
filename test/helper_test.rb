require_relative "test_helper"

class HelperTest < Minitest::Test
  def test_clear_screen
    expects(:system).at_least_once
    clear_screen
  end

  def test_dice
    assert_includes 1..6, roll_dice
  end

  def test_default_loading
    output, errors = capture_io do
      print_loading
    end
    assert_equal ". . .", output
    assert_empty errors
  end

  def test_custom_loading
    output, errors = capture_io do
      print_loading(5)
    end
    assert_equal ". . . . .", output
    assert_empty errors
  end

  def test_get_user_choice
    valid_choices = [1, 2, 3]
    user_input = "1"
    STDIN.stubs(:gets).returns(user_input)

    capture_io do
      selected_choice = get_user_choice(valid_choices)
      assert_equal user_input, selected_choice
    end
  end

  def test_user_selects_exit_choice
    valid_choices = [1]
    possible_user_inputs = ["exit", "EXIT", "ExIt"]

    possible_user_inputs.each do |user_input|
      STDIN.expects(:gets).returns(user_input)
      expects(:clear_screen)

      output, errors = capture_io do
        assert_raises SystemExit do
          selected_choice = get_user_choice(valid_choices)
        end
      end

      assert_match /Cya!/, output
      assert_empty errors
    end
  end

  def test_user_inserts_an_invalid_choice_and_after_a_valid_one
    valid_choices = [1, 2]
    first_user_input = "0"
    second_user_input = "1"
    invalid_input_message = <<~HEREDOC
      '0' is not a valid choice.

      Try again:
    HEREDOC
    STDIN.expects(:gets).twice.returns(first_user_input, second_user_input)

    selected_choice = ""
    output, errors = capture_io do
      selected_choice = get_user_choice(valid_choices)
    end
    assert_match invalid_input_message, output
    assert_equal second_user_input, selected_choice
    assert_empty errors
  end

  def test_exit_game
    expects(:clear_screen)
    expects(:exit)
    
    capture_io do
      exit_game
    end
  end
end