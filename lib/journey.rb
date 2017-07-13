class Journey

  attr_reader :fare
  PENALTY_FARE = 6
  DEFAULT_MIN_FARE = 1

  def initialize
    @fare = PENALTY_FARE
    @completed = false
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(station)
    @entry_station = station
  end

  def end_journey(station)
    complete_journey if @entry_station != nil
    @exit_station = station
  end

  def completed?
    @completed
  end

  def in_journey?
    @entry_station != nil && @exit_station == nil
  end

  private

  def complete_journey
    calculate_fare
    @completed = true
  end

  def calculate_fare
    @fare = DEFAULT_MIN_FARE
  end
end
