class Contact

  @@counter = 1000 #class variable 

  attr_accessor :name, :id, :address, :phone, :email, :notes

  def initialize
    @id = Contact.get_id #invoke class methods
    @notes = []
    #@notes = Notes.new
  end

  def to_s
    "ID: #{@id}\nName: #{@name}\nAddress: #{@address}\nPhone: #{@phone}\nE-mail: #{@email}\nNotes:#{@notes}\n" + "------------------".blue
  end

  def self.get_id # = class method / there are other 3 ways for class methods - which ones? 
    @@counter += 1
    @@counter
  end

end