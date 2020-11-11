class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @status = 'pending'
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    return true if @sender.valid? && @receiver.valid?
      
    return false
  end

  def execute_transaction
    if valid? && @status == 'pending'
      if @sender.balance > @amount
        @sender.withdraw(@amount)
        @receiver.deposit(@amount)
        @status = 'complete'
      else
        @status = 'rejected'
        return "Transaction rejected. Please check your account balance."
      end
    else
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @sender.deposit(@amount)
      @receiver.withdraw(@amount)
      @status = 'reversed'
    end
  end

end
