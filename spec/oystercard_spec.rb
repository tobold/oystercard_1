require 'oystercard'


describe Oystercard do
  subject(:card) {described_class.new}

  let(:limit) {Oystercard::DEFAULT_LIMIT}
  let(:amount) { 10 }

  describe "Initialization" do
    it 'checks a new card has balance of zero' do
      expect(card.balance).to eq 0
    end

    it 'registers new cards as #in_journey false' do
      expect(card.in_journey?).to eq false
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

    it 'registers as #in_journey? after touching in' do
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'registers as not #in_journey? after touching out' do
      card.touch_in
      card.touch_out
      expect(card).to_not be_in_journey
    end

    it 'deducts a specific fare after touching in and out' do
      card.touch_in
      expect { card.touch_out }.to change{ card.balance }.by(- Oystercard::DEFAULT_MIN_FARE)
    end

    it 'stores entry_station as a variable when touching in' do
      card.touch_in
      expect(card.entry_station).to be
    end
  end

  describe "Card errors" do
    it '#touch_in raises error if card balance is less than minimum' do
      expect{card.touch_in}.to raise_error 'Balance is too low'
    end
  end
end

#1) Write test for after touch in, card has variable 'entry_station'
#2) Make an entry station double in tests (returns itself when intialised)
#3) Make it pass by altering touch_in method
#4) Make existing tests pass again (the ones that were using touch_in)
#5) Make a test to check that entry_station is set to nil after touch_out is called
#6) Make test pass
#7) Make test to check in_journey? method
#8) Remove in_journey variable and make tests point to this
