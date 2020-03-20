require('minitest/autorun')
require('minitest/reporters')

require_relative('../item')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ItemTest < Minitest::Test

  def setup
    @item1 = Item.new("coke", 3)
  end

  def test_item_has_name()
    assert_equal("coke", @item1.name())
  end

  def test_item_has_price()
    assert_equal(3, @item1.price)
  end

end
