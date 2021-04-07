class Oystercard
  attr_accessor :balance
  attr_reader :entry_station

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "The maximum balance of #{MAX_BALANCE} has been reached" if  max?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    raise "Error: insufficient funds" if @balance < MIN_FARE
    @entry_station = entry_station
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
  end


  private 

  def deduct(deduction)
    @balance -= deduction
  end

  def max?(amount)
    balance + amount > MAX_BALANCE
  end
end