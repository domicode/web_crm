class Rolodex

  attr_reader :contacts

  def initialize
    @contacts = []
    @id = 1000
  end

  def create_contact(name)
    contact = Contact.new
    contact.name = name
    @contacts << contact
  end

  def add_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end

end