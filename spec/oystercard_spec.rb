require 'oystercard'

describe Oystercard do
  let(:entry_station){double :station}
  let(:exit_station){double :station}
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

    before do
      subject.top_up(5)
    end

      context 'journey stages' do
        before do
          subject.touch_in(entry_station)
        end

        it 'can touch in' do
          expect(subject).to be_in_journey
        end

        it 'stores the entry station' do
          expect(subject.entry_station).to eq entry_station
        end

        it 'can touch out' do
          subject.touch_out(exit_station)
          expect(subject).not_to be_in_journey
        end

        it 'stores exit station' do
          subject.touch_out(exit_station)
          expect(subject.exit_station).to eq exit_station
        end

        it 'should deduct a minimum fare on touch out' do
          expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_FARE)
        end

        it 'should have an empty list of journeys by default' do
          expect(subject.journey).to be_empty
        end

        let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

          it 'stores a journey' do
            subject.touch_in(entry_station)
            subject.touch_out(exit_station)
            expect(subject.journey).to include journey
          end


      end
    end

    it 'will not touch in if below minimum balance' do
      expect{ subject.touch_in(entry_station) }.to raise_error "Balance not enough"
    end


end
