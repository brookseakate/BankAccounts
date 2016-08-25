# @todo link owners & accounts
# @todo integrate money gem
# @todo line 24: try out rescue instead of ArgumentError? 


require_relative 'owner'
require 'csv'

module Bank
  class Account
    attr_accessor :balance, :account_id, :owner, :open_date

    # initialize with parameters:
    # - account_id = Fixnum
    # - start_balance = Fixnum (cents)
    # - open_date = Datetime
    # - owner = Owner (if passed no Owner object, initialize a default Owner named "The_Bank")
    def initialize(account_id, start_balance, open_date, owner = Owner.new({last_name: "The_Bank"}))
      if start_balance.to_i >= 0 && start_balance.class == Fixnum
        @balance = start_balance
      else
        raise ArgumentError, "Start balance must be a positive integer (balance of account in cents)"
      end # if
      #@todo - rescue?
      #start_balance.to_f < 0 || ( start_balance.class == Float || start_balance.class == Fixnum ) puts "Rescue"

      @account_id = account_id
      @owner = owner
      @open_date = open_date
    end #initialize

    # withdraw method that accepts a single parameter which represents the amount of money that will be withdrawn.
    def withdraw(amount)
      if amount <= @balance
        @balance -= amount
      else
        puts "Insufficient funds: Cannot withdraw #{ amount } from account." +
        " Current balance is: #{ @balance } cents."
      end
      return @balance
    end #withdraw

    # deposit method that accepts a single parameter which represents the amount of money that will be deposited.
    def deposit(amount)
      @balance += amount
      return @balance
    end #deposit

    def self.all
      all_accounts = {}
      CSV.read('support/accounts.csv').each do |line|
        all_accounts[line[0].to_i] = self.new(line[0].to_i, line[1].to_i, line[2])
      end
      return all_accounts
    end # self.all

    def self.find(id)
      return self.all[id]
    end

  end # Account
end # Bank
