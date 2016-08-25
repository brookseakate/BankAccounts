require 'csv'

module Bank
  class Owner
    attr_accessor :owner_id, :first_name, :last_name, :street_number, :street_name, :city, :state, :zip, :phone_number, :email_address

    def initialize(owner_info_hash)
      @owner_id = owner_info_hash[:owner_id]
      @first_name = owner_info_hash[:first_name]
      @last_name = owner_info_hash[:last_name]
      @street_number = owner_info_hash[:street_number]
      @street_name = owner_info_hash[:street_name]
      @city = owner_info_hash[:city]
      @state = owner_info_hash[:state]
      @zip = owner_info_hash[:zip]
      @phone_number = owner_info_hash[:phone_number]
      @email_address = owner_info_hash[:email_address]
    end

    # The data, in order in the CSV, consists of:
    # ID - (Fixnum) a unique identifier for that Owner
    # Last Name - (String) the owner's last name
    # First Name - (String) the owner's first name
    # Street Addess - (String) the owner's street address
    # City - (String) the owner's city
    # State - (String) the owner's state
    def self.all
      all_owners = {}
      CSV.open('support/owners.csv').each do |line|
        # split Street Address data in csv into street_number & street_name
        s_address = line[3].split
        s_num = s_address[0]
        s_name = s_address[1..-1].join(' ')
        # s_num = line[3].split[0]
        # s_name = line[3].split[1..-1].join(' ')

        # populate a hash of owner info from each CSV line
        new_owner_hash = {
          owner_id: line[0].to_i,
          last_name: line[1],
          first_name: line[2],
          street_number: s_num,
          street_name: s_name,
          city: line[4],
          state: line[5]
        }

        # pass new_owner_hash to Owner constructor, add each new account to all_owners hash, using owner_id as key
        all_owners[line[0].to_i] = self.new(new_owner_hash)
      end
      return all_owners
    end

    # self.find(id) - returns an instance of Owner where the value of the id field in the CSV matches the passed parameter
    def self.find(id)
      return self.all[id]
    end

  end # Owner class
end # Bank module
