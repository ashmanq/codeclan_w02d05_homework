require('minitest/autorun')
require('minitest/reporters')

require_relative('../karaoke_bar')
require_relative('../room')
require_relative('../guest')
require_relative('../song')


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

    @room1 = Room.new("Earblaster Room", @songs_room1, 10)
    @room2 = Room.new("Mozart Room", @songs_room2, 10)

    @new_room = Room.new("JPop Room", @songs_room2, 15)

    @rooms = [@room1, @room2]

    @karaoke_bar1 = KaraokeBar.new("Doki Doki Sing Song!", @rooms)

    #@random_song = Song.new("Random song name", "rubbish artist")

  end

  def test_karaoke_bar_has_name()
    assert_equal("Doki Doki Sing Song!", @karaoke_bar1.name())
  end

  def test_karaoke_bar_till_starts_at_zero()
    assert_equal(0, @karaoke_bar1.till())
  end

  def test_karaoke_bar_has_rooms()
    assert_equal(2, @karaoke_bar1.room_count())
  end

  def test_karaoke_bar_has_rooms()
    assert_equal(2, @karaoke_bar1.room_count())
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

  def test_karaoke_bar_add_to_till()
    assert_equal(10, @karaoke_bar1.add_to_till(10))
  end





end
