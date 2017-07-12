class Journey
  attr_reader :in_journey, :fare
  def initialize
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
    @fare = 1
  end

  def start_journey(station)
    @in_journey == true ? penalty_fare : @fare = 1
    @in_journey = true
    @entry_station = station
  end

  def end_journey(station)
    @in_journey == false ? penalty_fare : @fare = 1
    @in_journey = false
    @exit_station = station
  end

  private
  def penalty_fare
    @fare = 6
  end
end
