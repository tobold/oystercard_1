require 'oystercard'

describe Oystercard do
subject(:card) {described_class.new}

  it 'checks a new card has balance of zero' do
    expect(card.balance).to eq 0
  end

end
