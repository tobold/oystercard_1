require_relative 'journey'

class Oystercard
DEFAULT_LIMIT = 90
attr_reader :balance, :entry_station, :journey_history

  def initialize
    @journey_history = []
    @balance = 0
    @in_journey = false
  end

  def topup(amount)
    raise 'Action would exceed card limit' if (@balance + amount) > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < Journey::DEFAULT_MIN_FARE
    deduct(lastjourney.fare) if in_journey?
    @in_journey = true
    create_journey
    lastjourney.start_journey(station)
  end

  def touch_out(station)
    create_journey if !in_journey?
    @in_journey = false
    lastjourney.end_journey(station)
    deduct(lastjourney.fare)
  end

  def in_journey?
    @in_journey
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
