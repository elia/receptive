require "test_helper"

class ReceptiveTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Receptive::VERSION
  end

  def test_path_has_been_added_to_opal
    assert (Opal.paths & Receptive.paths) == Receptive.paths
  end
end
