class Oystercard
  attr_accessor :balance, :in_journey

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @in_journey = false
    @balance = 0
  end

  def top_up(amount)
    raise "The maximum balance of #{MAX_BALANCE} has been reached" if  max?(amount)
    @balance += amount
  end

  def deduct(deduction)
    @balance -= deduction
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Error: insufficient funds" if @balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end


  private 

  def max?(amount)
    balance + amount > MAX_BALANCE
  end
end