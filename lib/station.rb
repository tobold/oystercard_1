class Station
  attr_reader :name, :zone

  def initialize(name, zone)
    fail "Please enter a zone number between 1-7" if zone > 7 || zone < 0
    @name = name
    @zone = zone
  end
end
