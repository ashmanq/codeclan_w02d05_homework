require('minitest/autorun')
require('minitest/reporters')

require_relative('../karaoke_bar')
require_relative('../room')
require_relative('../guest')
require_relative('../song')
require_relative('../item')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class KaraokeBarTest < Minitest::Test

  def setup
    @song1 = Song.new("7 rings", "Ariana Grande")
    @song2 = Song.new("Eye of the tiger", "Survivor")
    @song3 = Song.new("bad guy", "Billie Eilish")
    # We create an array of the above songs to store within
    # the room object as each room will have more than one
    # song available....hopefully!
    @songs_room1 = [@song1, @song2]
    @songs_room2 = [@song2, @song3]

    @new_song = Song.new("No one will save you", "Aviators")

    @item1 = Item.new("coke", 3)
    @item2 = Item.new("cake", 4)
    @item3 = Item.new("nachos", 5)

    @items = [@item1, @item2, @item3]

    @room1 = Room.new("Earblaster Room", @songs_room1, 10, @items)
    @room2 = Room.new("Mozart Room", @songs_room2, 1, @items)

    @new_room = Room.new("JPop Room", @songs_room2, 15, @items)

    @rooms = [@room1, @room2]

    @karaoke_bar1 = KaraokeBar.new("Doki Doki Sing Song!", @rooms, 10)

    @guest1 = Guest.new("I M Legend", 100, @song1)
    @guest2 = Guest.new("I C you", 500, @song2)

  end

  def test_karaoke_bar_has_name()
    assert_equal("Doki Doki Sing Song!", @karaoke_bar1.name())
  end

  def test_karaoke_bar_has_rooms()
    assert_equal(2, @karaoke_bar1.room_count())
  end

  def test_karaoke_bar_entry_fee_is_specified()
    assert_equal(10, @karaoke_bar1.entry_fee())
  end

  def test_change_karaoke_bar_entry_fee()
    assert_equal(120, @karaoke_bar1.entry_fee = 120)
  end

  def test_find_room__room_doesnt_already_exist()
    assert_equal(false, @karaoke_bar1.find_room("Random Room"))
  end

  def test_find_room__room_already_exist()
    assert_equal(true, @karaoke_bar1.find_room("Earblaster Room"))
  end

  def test_add_room_to_karaoke_bar()
    @karaoke_bar1.add_room(@new_room)
    assert_equal(3, @karaoke_bar1.room_count())
  end

  def test_remove_room_from_karaoke_bar()
    @karaoke_bar1.remove_room(@room1)
    assert_equal(1, @karaoke_bar1.room_count())
  end

  def test_check_guest_in__can_afford_entry_fee_enough_capacity()
    @karaoke_bar1.check_guest_into_room(@room1, @guest1)
    guests_in_room = @room1.guest_count()
    assert_equal(1, guests_in_room)
    assert_equal(10, @room1.tab())
  end

  def test_check_guest_in__can_afford_and_NOT_enough_capacity()
    @karaoke_bar1.check_guest_into_room(@room2, @guest1)
    @karaoke_bar1.check_guest_into_room(@room2, @guest2)
    guests_in_room = @room2.guest_count()
    assert_equal(1, guests_in_room)
    assert_equal(10, @room2.tab())
  end

  def test_check_guest_in__can_NOT_afford_entry_fee_enough_capacity()
    @karaoke_bar1.entry_fee = 300
    @karaoke_bar1.check_guest_into_room(@room1, @guest1)
    guests_in_room = @room1.guest_count()
    assert_equal(0, guests_in_room)
    assert_equal(0, @room1.tab())
  end

  def test_check_if_guests__fav_song_available()
    message = @karaoke_bar1.check_guest_into_room(@room1, @guest1)
    assert_equal("Yeeha! my fav song in da world!", message)
  end

  def test_check_if_guests__fav_song_NOT_available()
    message = @karaoke_bar1.check_guest_into_room(@room2, @guest1)
    assert_equal("Aww, all duds...", message)
  end

  def test_guest_pays_tab()
    @karaoke_bar1.check_guest_into_room(@room1, @guest1)

    @room1.buy_item(@item1)
    @karaoke_bar1.pay_tab(@room1, @guest1)
    assert_equal(87, @guest1.wallet())
    assert_equal(0, @room1.tab())
  end

end
