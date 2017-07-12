class Journey
  attr_reader :fare
  def initialize
    @in_journey = false
    @fare = 1
    @completed = false
  end

  def start_journey(station)
    penalty_fare if @in_journey
    @in_journey = true
    @entry_station = station
  end

  def end_journey(station)
    @in_journey == false ? penalty_fare : complete_journey
    @in_journey = false
    @exit_station = station
  end

  def completed?
    @completed
  end

  def in_journey?
    @in_journey
  end

  private

  def complete_journey
    calculate_fare
    @completed = true
  end

  def calculate_fare
    @fare = 1
  end

  def penalty_fare
    @fare = 6
  end
end
