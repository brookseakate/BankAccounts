require_relative 'owner'

module Bank
  class Account
    attr_accessor :balance, :id, :owner

    def initialize(owner, start_balance) #start_balance = Fixnum (cents)
      if start_balance.to_f >= 0 && start_balance.class == Fixnum
        @balance = start_balance
      else
        raise ArgumentError, "Start balance must be a positive integer (balance of account in cents)"
      end

      @id = rand(1000000..9999999)
      @owner = owner

      #@todo ? - rescue?
      #start_balance.to_f < 0 || ( start_balance.class == Float || start_balance.class == Fixnum ) puts "Rescue"
    end

    # withdraw method that accepts a single parameter which represents the amount of money that will be withdrawn.
    def withdraw(amount)
      if amount <= @balance
        @balance -= amount
      else
        puts "Insufficient funds: Cannot withdraw $#{ amount.round(2) } from account." +
        " Current balance is: $#{ @balance }"
      end
      return @balance
    end

    # deposit method that accepts a single parameter which represents the amount of money that will be deposited.
    def deposit(amount)
      @balance += amount
      return @balance
    end

    #@todo - is this method necessary?
    def print_balance
      puts @balance.to_s
    end

  end #Account
end #Bank
