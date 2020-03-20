require('minitest/autorun')
require('minitest/reporters')

require_relative('../room')
require_relative('../song')
require_relative('../guest')
require_relative('../item')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class RoomTest < Minitest::Test

  def setup
    @song1 = Song.new("7 rings", "Ariana Grande")
    @song2 = Song.new("Eye of the tiger", "Survivor")
    @song3 = Song.new("bad guy", "Billie Eilish")
    # We create an array of the above songs to store within
    # the room object as each room will have more than one
    # song available....hopefully!
    @songs = [@song1, @song2, @song3]

    @new_song = Song.new("No one will save you", "Aviators")

    @item1 = Item.new("coke", 3)
    @item2 = Item.new("cake", 4)
    @item3 = Item.new("nachos", 5)

    @items = [@item1, @item2, @item3]

    @room1 = Room.new("Earblaster", @songs, 10, @items)

    @guest1 = Guest.new("Bob Dylan", 200, @new_song)
  end

  def test_room_has_name()
    assert_equal("Earblaster", @room1.name)
  end

  def test_room_name_can_be_changed()
    @room1.name = "Crappy Singers Here!"
    assert_equal("Crappy Singers Here!", @room1.name)
  end

  def test_room_bar_tab_starts_at_zero()
    assert_equal(0, @room1.tab())
  end

  def test_add_to_tab()
    @room1.add_to_tab(20)
    assert_equal(20, @room1.tab())
  end

  def test_pay_tab()
    @room1.add_to_tab(20)
    @room1.reduce_tab(10)
    assert_equal(10, @room1.tab())
  end

  def test_room_has_max_capacity()
    assert_equal(10, @room1.capacity())
  end

  def test_room_cant_exceed_max_capacity()
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    assert_equal(10, @room1.capacity())
  end

  def test_room_has_songs()
    assert_equal(3, @room1.song_count())
  end

  def test_can_add_song_to_room__new_song()
    # The new song should be added to the songs list
    @room1.add_song(@new_song)
    assert_equal(4, @room1.song_count())
  end

  def test_can_add_song_to_room__song_already_exists()
    # The song shouldn't be added if it already exists
    @room1.add_song(@song1)
    assert_equal(3, @room1.song_count())
  end

  def test_find_song_by_name_from_song_list__song_in_list()
    result = @room1.find_song(@song1)
    assert_equal(true, result)
  end

  def test_find_song_by_name_from_song_list__song_not_in_list()
    result = @room1.find_song(@new_song)
    assert_equal(false, result)
  end

  def test_can_remove_song_from_room__song_in_list()
    # The song shouldn't be added if it already exists
    @room1.remove_song(@song1)
    assert_equal(2, @room1.song_count())
  end

  def test_can_remove_song_from_room__song_not_in_list()
    @room1.remove_song(@new_song)
    assert_equal(3, @room1.song_count())
  end

  def test_no_guests_in_room_when_created()
    assert_equal(0, @room1.guest_count())
  end

  def test_find_guest_by_name_in_room__guest_not_in_room()
    result = @room1.find_guest("Fred Flinstone")
    assert_equal(false, result)
  end

  def test_find_guest_by_name_in_room__guest_in_room()
    @room1.add_guest(@guest1)
    result = @room1.find_guest(@guest1.name)
    assert_equal(true, result)
  end

  def test_add_guest_to_room__guest_not_already_in_room()
    @room1.add_guest(@guest1)
    assert_equal(1, @room1.guest_count())
  end

  def test_add_guest_to_room__guest_already_in_room()
    @room1.add_guest(@guest1)
    @room1.add_guest(@guest1)
    assert_equal(1, @room1.guest_count())
  end

  def test_remove_guest_from_room__guest_in_room()
    @room1.add_guest(@guest1)
    @room1.remove_guest(@guest1)
    assert_equal(0, @room1.guest_count())
  end

  def test_remove_guest_from_room__guest_not_in_room()
    @room1.remove_guest(@guest1)
    assert_equal(0, @room1.guest_count())
  end

  def test_room_has_items()
    assert_equal(3, @room1.item_count())
  end

  # def test_guest_buys_items__guest_checked_in_room()
  #   @room1.add_guest(@guest1)
  #   @room1.buy_item(@guest1, @item1)
  #   assert_equal(3, @room1.tab)
  # end
  #
  # def test_guest_buys_items__guest_NOT_checked_in_room()
  #   @room1.buy_item(@guest1, @item1)
  #   assert_equal(0, @room1.tab)
  # end

  # def test_guest_pays_tab__has_enough_money()
  #   @room1.add_guest(@guest1)
  #   @room1.buy_item(@item1)
  #   @room1.pay_tab(@guest1)
  #   assert_equal(197, @guest1.wallet())
  #   assert_equal(0, @room1.tab())
  # end
  #
  # def test_guest_pays_tab__DOESNT_have_enough_money()
  #   guest = Guest.new("Broke Dude", 1)
  #   @room1.add_guest(@guest1)
  #   @room1.buy_item(@item1)
  #   @room1.pay_tab(@guest1)
  #   assert_equal(197, @guest1.wallet())
  #   assert_equal(0, @room1.tab())
  # end

end
