require_relative 'account'
require_relative 'owner'

module Bank
  class SavingsAccount < Account
    MINIMUM_BALANCE = 1000
    WITHDRAWAL_FEE = 200

    attr_accessor

    def initialize(account_id, start_balance, open_date, owner = Owner.new({last_name: "The_Bank"}))
      super(account_id, start_balance, open_date, owner)
    end # initialize

    # #add_interest(rate): Calculate the interest on the balance and add the interest to the balance. Return the interest that was calculated and added to the balance (not the updated balance).
    # Input rate is assumed to be a percentage (i.e. 0.25).
    # The formula for calculating interest is balance * rate/100
    # Example: If the interest rate is 0.25% and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.
    def add_interest(rate)
      interest = (@balance * rate.to_f/100).round
      @balance += interest
      return interest
    end




  end # SavingsAccount class
end # Bank module
