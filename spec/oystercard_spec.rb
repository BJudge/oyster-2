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


    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

  describe '#touch_in and #touch_out' do
    let(:station){ double :station }
    before do
      subject.top_up(5)
    end


      it 'can touch in' do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it 'stores the entry station' do
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end

      it 'can touch out' do
        subject.touch_in(station)
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it 'should deduct a minimum fare on touch out' do
        subject.touch_in(station)
        expect{ subject.touch_out }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end
    end

    it 'will not touch in if below minimum balance' do
      expect{ subject.touch_in(:station) }.to raise_error "Balance not enough"
    end


end
