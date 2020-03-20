require('minitest/autorun')
require('minitest/reporters')

require_relative('../guest')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class GuestTest < Minitest::Test

  def setup
    @guest1 = Guest.new("James Jameson")
  end

  def test_guest_has_name()
    assert_equal("James Jameson", @guest1.name)
  end

end
