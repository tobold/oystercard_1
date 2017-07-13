require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  let(:limit) {Oystercard::DEFAULT_LIMIT}
  let(:amount) { 10 }
  let(:station) { double(:station, name: "Station name", zone: 1) }
  let(:journey) { double(:journey) }

  describe "Initialization" do
    it 'checks a new card has balance of zero' do
      expect(card.balance).to eq 0
    end

    it 'registers new cards as #in_journey false' do
      expect(card.in_journey?).to eq false
    end

    it 'checks a new card has an empty journey_history hash' do
      expect(card.journey_history).to be_empty
    end
  end

  describe "Altering balance" do
    it 'allows you to topup the balance by a specified amount' do
      card.topup(amount)
      expect(card.balance).to eq amount
    end

    it 'error raised when attempting to raise balance above £90' do
      expect { card.topup(limit + 1) }.to raise_error 'Action would exceed card limit'
    end
  end

  context "Journeys on loaded card" do
    before {card.topup(amount)}
    before {card.touch_in(station)}

    it 'registers as #in_journey? after touching in' do
      expect(card).to be_in_journey
    end

    it 'registers as not #in_journey? after touching out' do
      card.touch_out(station)
      expect(card).to_not be_in_journey
    end

    it 'deducts a specific fare after touching in and out' do
      expect { card.touch_out(station) }.to change{ card.balance }.by(- 1)
    end

    it 'stores a new instance of Journey in @journey_history' do
      expect(card.journey_history[0]).to be_an_instance_of(Journey)
    end

    it 'should deduct the penalty when touching in twice' do
      expect { card.touch_in(station) }.to change{ card.balance }.by(- 6)
    end
  end

  describe "Card errors" do
    it '#touch_in raises error if card balance is less than minimum' do
      expect{card.touch_in(station)}.to raise_error 'Balance is too low'
    end
  end
end

#3) touch out pushes saved station info to 'journey_history' hash
