# @todo integrate money gem
# @todo POODR-ize
# @todo double-check rounding (savings_account account?)

require_relative 'owner'
require 'csv'
require 'awesome_print'

module Bank
  class Account
    MINIMUM_BALANCE = 0
    WITHDRAWAL_FEE = 0

    attr_accessor :balance, :account_id, :owner, :open_date

    # initialize with parameters:
    # - account_id = Fixnum
    # - start_balance = Fixnum (cents)
    # - open_date = Datetime
    # - owner = Owner (If passed a Hash rather than an Owner object, attempt to
    # initialize a new Owner from the Hash. If passed no owner argument,
    # initialize a new Owner object with default last_name "The_Bank")
    def initialize(account_id, start_balance, open_date, owner = Owner.new({last_name: "The_Bank"}))
      # Check that start_balance argument is a Fixnum & meets minimum balance
      if start_balance.to_i >= self.class::MINIMUM_BALANCE && start_balance.class == Fixnum
        @balance = start_balance
      else
        raise ArgumentError, "Start balance must be greater than minimum balance: #{ self.class::MINIMUM_BALANCE } cents"
      end

      # Check that owner argument is an Owner object
      if owner.class != Owner
        # If owner argument is a hash, attempt to initialize an Owner from it
        if owner.class == Hash
          owner = Owner.new(owner)
        else
          raise ArgumentError, "Invalid owner info provided"
        end
      end

      @account_id = account_id
      @open_date = open_date
      @owner = owner
    end #initialize

    # withdraw method that accepts a single parameter which represents the amount of money that will be withdrawn.
    def withdraw(amount)
      # Make sure requested amount + withdrawal fee can be deducted without putting account below min balance
      if @balance - amount - self.class::WITHDRAWAL_FEE >= self.class::MINIMUM_BALANCE
        @balance -= amount
        @balance -= self.class::WITHDRAWAL_FEE
      else
        puts "Insufficient funds: Cannot withdraw #{ amount } cents from account.",
        "Minimum balance is #{ self.class::MINIMUM_BALANCE } cents. "+
        "Withdrawal fee is #{ self.class::WITHDRAWAL_FEE } cents.",
        "Current balance is: #{ @balance } cents."
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

    # all_with_owner: create accounts with linked owners from CSVs

    # To create the relationship between the accounts and the owners use the account_owners CSV file. The data for this file, in order in the CSV, consists of:
    # Account ID - (Fixnum) a unique identifier corresponding to an account
    # Owner ID - (Fixnum) a unique identifier corresponding to an owner
    def self.all_with_owner
      all_owners = Owner.all
      all_accounts = self.all
      CSV.read('support/account_owners.csv').each do |line|
        all_accounts[line[0].to_i].owner = all_owners[line[1].to_i]
      end
      ap all_accounts # @todo - remove/debug
      return all_accounts
    end # self.all

    def self.find(id)
      return self.all[id]
    end

    # @todo - remove/debug
    def print_props
      puts self.class.to_s + " info:"
      puts "@balance = " + @balance.to_s if @balance != nil
      puts "@account_id = " + @account_id.to_s if @account_id != nil
      puts "@open_date = " + @open_date.to_s if @open_date != nil
      puts "@owner = " + @owner.to_s if @owner != nil
    end

  end # Account class
end # Bank module
