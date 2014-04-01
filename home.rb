require "sinatra"
require_relative "contact" #??
require_relative "rolodex"

class Contact

  @@all_contacts = []

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.all_contacts
    @@all_contacts
  end

  def valid? 
    if name.empty? or name == "first name"
      false
    else 
      true
    end
  end

end



post "/contacts" do 
  puts params
  new_contact = Contact.new(params[:first_name])
  if !new_contact.valid?
    redirect to("/add_contact")# do something
  end
  Contact.all_contacts << new_contact
  redirect to ("/contacts") #add new contacs
end

get "/contacts" do
  @contacts = Contact.all_contacts
  erb :contacts
end

get "/add_contact" do
  erb :add_contact
end

# get "/:name" do
#   puts params
#   @name = params[:name].capitalize #make it an instance variable so that it's acceesible in the erb etemplate
#   erb :name
# end

get "/"  do #specific routes go to the bottom, individual ones are on top, like if else statement
  puts params
  erb :index
end