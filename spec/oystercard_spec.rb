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

  describe "Topping up" do
    it 'allows you to topup the balance by a specified amount' do
      card.topup(amount)
      expect(card.balance).to eq amount
    end

    it 'allows you to deduct an amount from the balance' do
      card.topup(amount)
      card.deduct(1)
      expect(card.balance).to eq (amount - 1)
    end

    it 'error raised when attempting to raise balance above £90' do
      expect{card.topup(limit + 1)}.to raise_error 'Action would exceed card limit'
    end
  end

  describe "Journeys" do
    it 'registers as #in_journey? after touching in' do
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'registers as not #in_journey? after touching out' do
      card.touch_in
      card.touch_out
      expect(card).to_not be_in_journey
    end
  end
end
