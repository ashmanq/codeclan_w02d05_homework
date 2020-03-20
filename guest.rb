
class Guest

  attr_reader :name, :wallet

  def initialize(name, money)
    @name = name
    @wallet = money
  end

  def get_money(amount)
    @wallet += amount
  end

  def give_money(amount)
    if amount <= @wallet
      @wallet -= amount
    end
  end

end
