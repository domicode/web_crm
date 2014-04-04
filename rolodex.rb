class Rolodex

  attr_reader :contacts, :contacts_sort

  def initialize
    @contacts = []
    @contacts_sort = []
    @id = 1000
  end


  def add_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end

  def find(contact_id)
    @contacts.find {|contact| contact.id == contact_id }
  end

  def remove_contact(contact)
    @contacts.delete(contact)
  end

  def search(name)
    @contacts.find {|contact| contact.last_name.downcase == name.downcase }
  end

  def sort
    @contacts_sort = @contacts.sort_by { |contact| contact.last_name.downcase }
  end


end