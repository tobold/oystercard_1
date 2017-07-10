require 'station'

class Oystercard
DEFAULT_LIMIT = 90
DEFAULT_MIN_FARE = 1
attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def topup(amount)
    raise 'Action would exceed card limit' if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in
    raise 'Balance is too low' if @balance < DEFAULT_MIN_FARE
    @in_journey = true
    @entry_station = Station.new
  end

  def touch_out
    deduct(DEFAULT_MIN_FARE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
