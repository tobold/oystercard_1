class Oystercard
DEFAULT_LIMIT = 90
attr_reader :balance

  def initialize
    @balance = 0
  end

  def topup(amount)
    raise 'Action would exceed card limit' if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
