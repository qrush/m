require "minitest/unit"

class Meme
  def i_can_has_cheezburger?
    "OHAI!"
  end

  def will_it_blend?
    "YES!"
  end
end

Test = M::Frameworks.minitest4? ? MiniTest::Unit::TestCase : Minitest::Test

class TestMeme < Test
  def setup
    @meme = Meme.new
  end

  def test_that_kitty_can_eat
    assert_equal "OHAI!", @meme.i_can_has_cheezburger?
  end

  def test_that_it_will_not_blend
    refute_match(/^maybe/i, @meme.will_it_blend?)
    refute_match(/^no/i, @meme.will_it_blend?)
    refute_match(/^lolz/i, @meme.will_it_blend?)
  end

  def test_that_kitty_can_eat_two_time
    assert_equal "OHAI!", @meme.i_can_has_cheezburger?
    assert_equal "OHAI!", @meme.i_can_has_cheezburger?
  end

  Minitest.after_run { p "ran after run block" } if Minitest.respond_to? :after_run
end
