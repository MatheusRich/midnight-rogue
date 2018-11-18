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

  def test_get_user_option
    valid_options = ["1", "2", "3"]
    user_input = "1"
    STDIN.expects(:gets).returns(user_input)

    capture_io do
      selected_option = get_user_option(valid_options)
      assert_equal user_input, selected_option
    end
  end

  def test_user_selects_exit_option
    valid_options = ["1"]
    possible_user_inputs = ["exit", "EXIT", "ExIt"]

    possible_user_inputs.each do |user_input|
      STDIN.expects(:gets).returns(user_input)
      expects(:clear_screen)

      capture_io do
        assert_raises SystemExit do
          selected_option = get_user_option(valid_options)
        end
      end
    end
  end

  def test_user_inserts_an_invalid_option_and_after_a_valid_one
    valid_options = ["1", "2"]
    first_user_input = "0"
    second_user_input = "1"
    invalid_input_message = <<~HEREDOC
      '0' is not a valid option.

      Try again:
    HEREDOC
    STDIN.expects(:gets).twice.returns(first_user_input, second_user_input)

    selected_option = ""
    output, errors = capture_io do
      selected_option = get_user_option(valid_options)
    end
    assert_match invalid_input_message, output
    assert_equal second_user_input, selected_option
    assert_empty errors
  end

  def test_exit_game
    expects(:clear_screen)
    expects(:exit)
    exit_game
  end
end