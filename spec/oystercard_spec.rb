require 'oystercard'

describe Oystercard do 

  it { is_expected.to respond_to(:in_journey?) }
  it { is_expected.to respond_to(:touch_in) }
  it { is_expected.to respond_to(:touch_out) }

  context '#initialize' do
    it { is_expected.to respond_to(:balance) }

    it 'has a default value' do
      expect(subject.balance).to eq(0)
    end

     it 'has a maximum balance' do
       expect(Oystercard::MAX_BALANCE).to eq 90
    end

    it 'raises an error when max reached' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error "The maximum balance of #{maximum_balance} has been reached"
    end
  end

  context '#injourney' do
    it 'should allow tell you if we are travelling' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'should tells you if you are not travelling' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

  context '#topup' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'Can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
  end

  context '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'Can deduct an amount from the balance' do
      subject.top_up(20)
      expect {subject.deduct 1 }.to change{ subject.balance }.by -1
    end
  end

end