require 'oystercard'

describe Oystercard do
  it 'has a balance of Zero' do
    expect(subject.balance).to eq 0
  end
    describe '#top_up' do
      # it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'can top up the balance' do
        expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
      end

      it 'has a maximum defualt capacity of £90' do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect{ subject.top_up 1 }.to raise_error "Maximum balance of £'#{maximum_balance}' exceeded"
      end
    end

    describe '#deduct' do
      # it { is_expected.to respond_to(:deduct).with(1).argument}

      it 'can reduce money from the balance' do
        subject.top_up(20)
        expect{ subject.deduct 3 }.to change{ subject.balance }.by -3
      end
    end

end
