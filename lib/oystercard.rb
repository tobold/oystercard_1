require_relative 'journey'
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
    if lastjourney != nil
      deduct(lastjourney.fare) if lastjourney.completed? == false
    end
    create_journey
    lastjourney.start_journey(station)
  end

  def touch_out(station)
    lastjourney.end_journey(station)
    deduct(lastjourney.fare)
  end

  def in_journey?
    lastjourney != nil ? lastjourney.in_journey? : false
  end

  private

  def create_journey
    @journey_history << Journey.new
  end

  def lastjourney
    @journey_history.last
  end

  def deduct(amount)
    @balance -= amount
  end
end
