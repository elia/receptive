require "test_helper"

class ReceptiveTest < Minitest::Test
  def test_silence_logs
    $DEBUG = true
    debug_value_inside_block = nil
    Receptive.silence_logs do
      debug_value_inside_block = $DEBUG
    end
    assert_equal(false, debug_value_inside_block)
  end
end
