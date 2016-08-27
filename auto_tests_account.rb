# @todo tests:
# - attempt to create Account with balance < 0
# - attempt to create SavingsAccount with balance < 10
# - attempt to withdraw from SavingsAccount & leave balance < 10
# - add interest to SavingsAccount

require_relative 'owner'
require_relative 'account'
require_relative 'savings_account'
require_relative 'checking_account'
require 'awesome_print'

puts "-"*80
############################################################################
puts "TEST 1: Owner o.
Should successfully create new Owner object from hash passed into Owner initializer."
puts '
o = Bank::Owner.new({first_name: "Kate", last_name: "Shaffer", street_number: "500", phone_number: 2065551212, city: "Seattle"}) =>'
puts
o = Bank::Owner.new({first_name: "Kate", last_name: "Shaffer", street_number: "500", phone_number: 2065551212, city: "Seattle"})
puts
p o
puts
o.print_props

puts "-"*80
############################################################################
puts "
TEST 2: Account a_def_owner.
Should successfully create new Account object with default owner (last_name: 'The_Bank')."
puts '
a_def_owner = Bank::Account.new(223423, 87786, "1999-03-27 11:30:09 -0800") =>'
puts
a_def_owner = Bank::Account.new(223423, 87786, "1999-03-27 11:30:09 -0800")
puts
p a_def_owner
puts
a_def_owner.print_props
puts "
a_def_owner.owner.print_props =>"
puts a_def_owner.owner.print_props

puts "-"*80
############################################################################
puts "
TEST 3: Account sa_hash_owner.
Should successfully create new SavingsAccount object & new Owner object from owner info
hash passed into SavingsAccount initializer"
puts '
sa_hash_owner = Bank::SavingsAccount.new(223423, 1000000, "1999-03-27 11:30:09 -0800", {first_name: "Jeff", last_name: "MacKay", street_number: "123", city: "Seattle"}) =>'
puts
sa_hash_owner = Bank::SavingsAccount.new(223423, 1000000, "1999-03-27 11:30:09 -0800", {first_name: "Jeff", last_name: "MacKay", street_number: "123", city: "Seattle"})
puts
p sa_hash_owner
puts
sa_hash_owner.print_props
puts "
sa_hash_owner.owner.print_props =>"
puts sa_hash_owner.owner.print_props

puts "-"*80
############################################################################
puts "
TEST 4: Account a_from_owner_obj.
Should successfully create new Account object from Owner object o (created in Test 1)"
puts '
a_from_owner_obj = Bank::Account.new(12345, 987664, "2015-03-27 11:30:09 -0800", o) =>'
puts
a_from_owner_obj = Bank::Account.new(12345, 987664, "2015-03-27 11:30:09 -0800", o)
puts
p a_from_owner_obj
puts
a_from_owner_obj.print_props
puts "
a_from_owner_obj.owner.print_props =>"
puts a_from_owner_obj.owner.print_props

puts "-"*80
############################################################################
puts "
TEST 5: Create CheckingAccount ca_def_owner with default Owner."
puts '
ca_def_owner = Bank::CheckingAccount.new(99, 130000, "2015-01-01") =>'
puts
ca_def_owner = Bank::CheckingAccount.new(99, 130000, "2015-01-01")
puts
p ca_def_owner
puts
ca_def_owner.print_props
puts
puts "
ca_def_owner.owner.print_props =>"
ca_def_owner.owner.print_props

puts "-"*80
############################################################################
puts "
WITHDRAWAL (WD) TESTS

WD TEST 1: Attempt to put SavingsAccount balance below min balance.
min balance: $10
withdrawal fee: $2

Withdrawal should FAIL. Should print warning & return original balance.

sa_hash_owner.print_props =>"
sa_hash_owner.print_props
puts '
sa_hash_owner.withdraw(998801) =>'
sa_hash_owner.withdraw(998801)
puts '
sa_hash_owner.print_props =>'
sa_hash_owner.print_props

puts "-"*80
############################################################################
puts "
WD TEST 2: Successfully withdraw from SavingsAccount.
min balance: $10
withdrawal fee: $2

Withdrawal should SUCCEED. Should return new balance (orig balance - withdrawal - fee).

sa_hash_owner.print_props =>"
sa_hash_owner.print_props
puts '
sa_hash_owner.withdraw(998800) =>'
puts sa_hash_owner.withdraw(998800)
puts '
sa_hash_owner.print_props =>'
sa_hash_owner.print_props

puts "-"*80
############################################################################
puts "
WD TEST 3: Attempt to put CheckingAccount balance below min $0.
min balance: $0
withdrawal fee: $1

Withdrawal should FAIL. Should print warning & return original balance.

ca_def_owner.print_props =>"
ca_def_owner.print_props
puts '
ca_def_owner.withdraw(129901) =>'
puts ca_def_owner.withdraw(129901)
puts '
ca_def_owner.print_props =>'
ca_def_owner.print_props

puts "-"*80
############################################################################
puts "
WD TEST 4: Successfully withdraw from CheckingAccount.
min balance: $0
withdrawal fee: $1

Withdrawal should SUCCEED. Should return new balance (orig balance - withdrawal - fee).

ca_def_owner.print_props =>"
ca_def_owner.print_props
puts '
ca_def_owner.withdraw(129900) =>'
puts ca_def_owner.withdraw(129900)
puts '
ca_def_owner.print_props =>'
ca_def_owner.print_props

puts "-"*80
############################################################################
puts "
WD TEST 5: Attempt to withdraw_using_check & leave CheckingAccount
balance below minimum balance using check -$10.
min balance with check: -$10
transaction fee: $0

Withdrawal should FAIL. Should print warning & return unchanged orig balance.

RE-INITIALIZE ca_def_owner with balance reset to 130000
ca_def_owner = Bank::CheckingAccount.new(99, 130000, '2015-01-01')"
puts ca_def_owner = Bank::CheckingAccount.new(99, 130000, "2015-01-01")
puts "
ca_def_owner.print_props =>"
ca_def_owner.print_props
puts '
ca_def_owner.withdraw_using_check(131001) =>'
puts ca_def_owner.withdraw_using_check(131001)
puts '
ca_def_owner.print_props =>'
ca_def_owner.print_props

puts "-"*80
############################################################################
puts "
WD TEST 6: Successfully withdraw with check from CheckingAccount.
min balance with check: - $10
transaction fee: $0

Withdrawal should SUCCEED. Should return new balance (orig balance - withdrawal).

RE-INITIALIZE ca_def_owner with balance reset to 130000
ca_def_owner = Bank::CheckingAccount.new(99, 130000, '2015-01-01')"
puts ca_def_owner = Bank::CheckingAccount.new(99, 130000, "2015-01-01")
puts "
ca_def_owner.print_props =>"
ca_def_owner.print_props
puts '
ca_def_owner.withdraw_using_check(130999) =>'
puts ca_def_owner.withdraw_using_check(130999)
puts '
ca_def_owner.print_props =>'
ca_def_owner.print_props

puts "-"*80
############################################################################
puts "
WD TEST 7 - REPEAT OF WD TEST 4
Attempt to withdraw small amount from CheckingAccount
*when already at a negative balance!*
min balance: $0
withdrawal fee: $1

Withdrawal should FAIL, because balance is already < 0.
Should warn and return orig balance.

ca_def_owner.print_props =>"
ca_def_owner.print_props
puts '
ca_def_owner.withdraw(1) =>'
puts ca_def_owner.withdraw(1)
puts '
ca_def_owner.print_props =>'
ca_def_owner.print_props

puts "-"*80
############################################################################
