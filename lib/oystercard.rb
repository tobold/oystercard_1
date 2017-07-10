class Oystercard
DEFAULT_LIMIT = 90
DEFAULT_MIN_FARE = 1
attr_reader :balance, :entry_station, :journey_history

  def initialize
    @journey_history = []
    @balance = 0
  end

  def topup(amount)
    raise 'Action would exceed card limit' if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < DEFAULT_MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(DEFAULT_MIN_FARE)
    @journey_history << { @entry_station => station }
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
