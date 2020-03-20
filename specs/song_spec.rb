require('minitest/autorun')
require('minitest/reporters')

require_relative('../song')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class SongTest < Minitest::Test

  def setup
    @song1 = Song.new("We Will Rock You!", "Queen")
  end

  def test_song_has_name
    assert_equal("We Will Rock You!", @song1.name)
  end

  def test_song_has_artist
    assert_equal("Queen", @song1.artist)
  end

end
