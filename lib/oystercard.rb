
class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :exit_station, :journey

  def initialize
    @balance = 0
    @journey = [ ]
  end

  def top_up(amount)
    fail "Maximum balance of £'#{MAXIMUM_BALANCE}' exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station
  end

  def touch_in(station)
    fail "Balance not enough" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    store_journey
  end

  private
    def deduct(amount)
      @balance -= amount
    end

    def store_journey
      journey << {:entry_station => @entry_station, :exit_station => @exit_station}
    end

end
