class Contact

  @@counter = 1000 #class variable 

  attr_accessor :first_name, :id, :last_name, :address, :phone, :email, :notes, :postcode, :place

  def initialize(first_name, last_name, address, place, postcode, email, notes)
    @id = Contact.get_id #invoke class methods
    @notes = []
    @first_name = first_name
    @last_name =last_name
    @address = address
    @email = email
    @postcode = postcode
    @place = place
    @notes = notes
    #@notes = Notes.new
  end

  def to_s
    "ID: #{@id}\nName: #{@name}\nAddress: #{@address}\nPhone: #{@phone}\nE-mail: #{@email}\nNotes:#{@notes}\n" + "------------------".blue
  end

  def self.get_id # = class method / there are other 3 ways for class methods - which ones? 
    @@counter += 1
    @@counter
  end

  def valid? 
    if first_name.empty? 
      false
    else 
      true
    end
  end

end