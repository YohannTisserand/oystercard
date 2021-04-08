require_relative 'station'

class Oystercard
  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journeys

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
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

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journeys << create_journey(@entry_station, exit_station)
    @exit_station = exit_station
    @entry_station = nil
  end

  def create_journey(entry_station, exit_station)
    {
      entry_station: entry_station,
      exit_station: exit_station
    } 
  end


  private 

  def deduct(deduction)
    @balance -= deduction
  end

  def max?(amount)
    balance + amount > MAX_BALANCE
  end
end