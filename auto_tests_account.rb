# @todo tests:
# - attempt to create Account with balance < 0
# - attempt to create SavingsAccount with balance < 10
# - attempt to withdraw from SavingsAccount & leave balance < 10
# - add intereste to SavingsAccount

require_relative 'owner'
require_relative 'account'
require_relative 'savings_account'
# require_relative 'checking_account'
require 'awesome_print'

puts "TEST 1: Owner o.
Should successfully create new Owner object from hash passed into Owner initializer."
puts '
o = Bank::Owner.new({first_name: "Kate", last_name: "Shaffer", street_number: "500", phone_number: 2065551212, city: "Seattle"})'
puts
o = Bank::Owner.new({first_name: "Kate", last_name: "Shaffer", street_number: "500", phone_number: 2065551212, city: "Seattle"})
puts
p o
puts
o.print_props
puts
puts
puts
puts


puts "
TEST 2: Account a_def_owner.
Should successfully create new Account object with default owner (last_name: 'The_Bank')."
puts '
a_def_owner = Bank::Account.new(223423, 87786, "1999-03-27 11:30:09 -0800")'
puts
a_def_owner = Bank::Account.new(223423, 87786, "1999-03-27 11:30:09 -0800")
puts
p a_def_owner
puts
a_def_owner.print_props
puts "
a_def_owner.owner.print_props"
puts a_def_owner.owner.print_props
puts
puts
puts
puts


puts "
TEST 3: Account sa_hash_owner.
Should successfully create new SavingsAccount object & new Owner object from owner info
hash passed into SavingsAccount initializer"
puts '
sa_hash_owner = Bank::SavingsAccount.new(223423, 1000000, "1999-03-27 11:30:09 -0800", {first_name: "Jeff", last_name: "MacKay", street_number: "123", city: "Seattle"})'
puts
sa_hash_owner = Bank::SavingsAccount.new(223423, 1000000, "1999-03-27 11:30:09 -0800", {first_name: "Jeff", last_name: "MacKay", street_number: "123", city: "Seattle"})
puts
p sa_hash_owner
puts
sa_hash_owner.print_props
puts "
sa_hash_owner.owner.print_props"
puts sa_hash_owner.owner.print_props
puts
puts
puts
puts


puts "
TEST 4: Account a_from_owner_obj.
Should successfully create new Account object from Owner object o (created in Test 1)"
puts '
a_from_owner_obj = Bank::Account.new(12345, 987664, "2015-03-27 11:30:09 -0800", o)'
puts
a_from_owner_obj = Bank::Account.new(12345, 987664, "2015-03-27 11:30:09 -0800", o)
puts
p a_from_owner_obj
puts
a_from_owner_obj.print_props
puts "
a_from_owner_obj.owner.print_props"
puts a_from_owner_obj.owner.print_props
puts
puts
puts
puts
