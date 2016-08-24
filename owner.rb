module Bank
  class Owner
    attr_accessor :first_name, :last_name, :street_number, :street_name, :city, :state, :zip, :phone_number, :email_address

    def initialize(owner_info_hash)
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
  end #Owner
end #Bank
