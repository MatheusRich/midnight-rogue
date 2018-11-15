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
    assert_equal ". . . ", output
  end

  def test_custom_loading
    output, errors = capture_io do
      print_loading(5)
    end
    assert_equal ". . . . . ", output
  end
end