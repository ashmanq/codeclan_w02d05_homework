require('minitest/autorun')
require('minitest/reporters')

require_relative('../guest')
require_relative('../song')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GuestTest < Minitest::Test

  def setup
    @fav_song1 = Song.new("Killing In The Name", "Rage Against The Machine" )
    @guest1 = Guest.new("James Jameson", 100, @fav_song1)
  end

  def test_guest_has_name()
    assert_equal("James Jameson", @guest1.name)
  end

  def test_guest_has_fav_song()
    assert_equal("Killing In The Name", @guest1.favourite_song.name)
  end

  def test_guest_starting_wallet_money()
    assert_equal(100, @guest1.wallet)
  end

  def test_add_to_wallet()
    @guest1.get_money(10)
    assert_equal(110, @guest1.wallet())
  end

  def test_give_money__enough_in_wallet()
    @guest1.give_money(90)
    assert_equal(10, @guest1.wallet())
  end

  def test_give_money__not_enough_in_wallet()
    @guest1.give_money(200)
    assert_equal(100, @guest1.wallet())
  end

  def test_give_money__just_enough_in_wallet()
    @guest1.give_money(100)
    assert_equal(0, @guest1.wallet())
  end
end
