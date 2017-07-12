require 'journey'
describe Journey do
  subject(:journey) { described_class.new }
  let(:station) {'aldgate'}
    it 'should by default not be in journey' do
      expect(journey.in_journey?).to eq false
    end
  describe "#start_journey" do
    it 'should set in_journey to true when start journey is called' do
      journey.start_journey(station)
      expect(journey.in_journey?).to eq true
    end
    it 'should set the penalty_fare when starting a journey twice' do
      2.times {journey.start_journey(station)}
      expect(journey.fare).to eq 6
    end
  end

  describe '#end_journey' do
    it 'should set in_journey? to false when end journey is called' do
      journey.end_journey(station)
      expect(journey.in_journey?).to eq false
    end

    it 'should set the penalty_fare when ending a journey twice' do
      2.times {journey.end_journey(station)}
      expect(journey.fare).to eq 6
    end
  end

  describe "complete journeys"
    it '#complete? method returns true after starting and ending a journey' do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.completed?).to be_truthy
    end
end
