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

    def add_interest(rate)
      interest = (@balance * rate.to_f/100).round
      @balance += interest
      return interest
    end

  end # SavingsAccount class
end # Bank module
