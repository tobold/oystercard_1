class Journey
  attr_reader :fare
  def initialize
    @fare = 6
    @completed = false
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
    @fare = 1
  end

  # def penalty_fare
  #   @fare = 6
  # end
end
