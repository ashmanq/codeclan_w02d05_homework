require('minitest/autorun')
require('minitest/reporters')

require_relative('../room')
require_relative('../song')
require_relative('../guest')


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

    @room1 = Room.new("Earblaster", @songs, 10)

    @random_song = Song.new("Random song name", "rubbish artist")
    @guest1 = Guest.new("Bob Dylan")
  end

  def test_room_has_name()
    assert_equal("Earblaster", @room1.name)
  end

  def test_room_name_can_be_changed()
    @room1.name = "Crappy Singers Here!"
    assert_equal("Crappy Singers Here!", @room1.name)
  end

  def test_room_has_max_capacity()
    assert_equal(10, @room1.room_capacity())
  end

  def test_room_cant_exceed_max_capacity()
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    assert_equal(10, @room1.room_capacity())
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
    result = @room1.find_song(@random_song)
    assert_equal(false, result)
  end

  def test_can_remove_song_from_room__song_in_list()
    # The song shouldn't be added if it already exists
    @room1.remove_song(@song1)
    assert_equal(2, @room1.song_count())
  end

  def test_can_remove_song_from_room__song_not_in_list()
    # The song shouldn't be added if it already exists
    @room1.remove_song(@random_song)
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
    @room1.check_in_guest(@guest1)
    result = @room1.find_guest(@guest1)
    assert_equal(true, result)
  end

  def test_check_in_guest_to_room__guest_not_already_in_room()
    @room1.check_in_guest(@guest1)
    assert_equal(1, @room1.guest_count())
  end

  def test_check_in_guest_to_room__guest_already_in_room()
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest1)
    assert_equal(1, @room1.guest_count())
  end

  def test_check_out_guest_from_room__guest_in_room()
    @room1.check_in_guest(@guest1)
    @room1.check_out_guest(@guest1)
    assert_equal(0, @room1.guest_count())
  end

  def test_check_out_guest_from_room__guest_not_in_room()
    @room1.check_out_guest(@guest1)
    assert_equal(0, @room1.guest_count())
  end



end
