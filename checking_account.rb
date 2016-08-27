require_relative 'account'
require_relative 'owner'

module Bank
  class CheckingAccount < Account
    WITHDRAWAL_FEE = 100
    MINIMUM_BALANCE_USING_CHECK = -1000
    CHECK_TRANSACTION_FEE = 200

    attr_accessor

    def initialize(account_id, start_balance, open_date, owner = Owner.new({last_name: "The_Bank"}))
      super(account_id, start_balance, open_date, owner)
      @checks_used = 0
    end # initialize

    # withdraw method is accessed directly from Account, no changes needed

    def charge_check_fee?
      if @checks_used >= 3
        return true
      end
    end # charge_check_fee? method

    def withdraw_using_check(amount)
      if charge_check_fee?
        fee_this_transaction = self.class::CHECK_TRANSACTION_FEE
      else
        fee_this_transaction = 0
      end

      balance_deduction = amount + fee_this_transaction

      if @balance - balance_deduction >= self.class::MINIMUM_BALANCE_USING_CHECK
        @balance -= balance_deduction
        @checks_used += 1
      else
        puts "Insufficient funds: Cannot withdraw #{ amount } cents from account.",
        "Minimum balance using a check is #{ self.class::MINIMUM_BALANCE_USING_CHECK } cents. " +
        "Fee for this transaction is: #{ fee_this_transaction }. " +
        "Current balance is: #{ @balance } cents."
      end
      return @balance
    end # withdraw_using_check method

    def reset_checks
      @checks_used = 0
    end # reset_checks method

  end # Account class
end # Bank module
