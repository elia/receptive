require "test_helper"

class ReceptiveViewTest < Minitest::Test
  def test_combine_selectors
    subject = Object.new.tap {|o| o.extend Receptive::View}

    assert_equal(''                   , subject.combine_selectors(nil         ))
    assert_equal('a'                  , subject.combine_selectors('a'         ))
    assert_equal('a b'                , subject.combine_selectors('a',   'b'  ))
    assert_equal('a c, b c'           , subject.combine_selectors('a,b', 'c'  ))
    assert_equal('a c, a d, b c, b d' , subject.combine_selectors('a,b', 'c,d'))
  end
end
