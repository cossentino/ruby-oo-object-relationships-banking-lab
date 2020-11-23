class Transfer

  attr_accessor :status, :sender, :receiver, :amount, :reverse_amount
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
    @reverse_amount = 0
  end

  def valid?
    self.sender.valid? && self.receiver.valid? ? true : false
  end

  def execute_transaction
    if (self.sender.balance <= self.amount) | (!self.sender.valid?) | (!self.receiver.valid?)
      self.status = 'rejected'
      "Transaction rejected. Please check your account balance."
    else
      self.sender.balance -= self.amount
      self.receiver.balance += self.amount
      self.reverse_amount = self.amount
      self.amount = 0
      self.status = 'complete'
    end
  end

  def reverse_transfer
    if self.valid? && self.receiver.balance >= self.reverse_amount
      self.receiver.balance -= self.reverse_amount
      self.sender.balance += self.reverse_amount
      self.status = 'reversed'
    end
  end

end
