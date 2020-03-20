
class Guest

  attr_reader :name, :wallet, :favourite_song

  def initialize(name, money, favourite_song)
    @name = name
    @wallet = money
    @favourite_song = favourite_song
  end

  def get_money(amount)
    @wallet += amount
  end

  def give_money(amount)
    if enough_money?(amount)
      @wallet -= amount
    end
  end

  def enough_money?(amount)
    return (amount <= @wallet) ? true : false
  end
end
