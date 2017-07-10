require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}

  it 'checks a new card has balance of zero' do
    expect(card.balance).to eq 0
  end

  it 'allows you to topup the balance by a specified amount' do
    card.topup(1000)
    expect(card.balance).to eq 1000
  end

end
