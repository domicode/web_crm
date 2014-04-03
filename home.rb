require "sinatra"
require_relative "contact" #??
require_relative "rolodex"

# class Contact

#   @@all_contacts = []

#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

#   def self.all_contacts
#     @@all_contacts
#   end

#   def valid? 
#     if name.empty? or name == "first name"
#       false
#     else 
#       true
#     end
#   end

# end

@@rolodex = Rolodex.new



post "/contacts" do 
  puts params
  # new_contact = Contact.new(params[:first_name])
  # Contact.all_contacts << new_contact
  # redirect to ("/contacts") #add new contacts
  new_contact = Contact.new(params[:first_name], params[:last_name], params[:address], params[:place], params[:postcode], params[:email], params[:textarea])
  if !new_contact.valid?
     redirect to("/add_contact")# do something
  end
  @@rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

get "/contacts" do
  @@rolodex
  erb :contacts
end

get "/contacts/:id" do #the :id will be transferred automattically through the params. :id can be a number, string whatever
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

# get "/add_contact" do
#   erb :new_contact
# end

get '/contacts/new' do
  erb :new_contact
end

get "contacts/:id/edit" do
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end




# get "/:name" do
#   puts params
#   @name = params[:name].capitalize #make it an instance variable so that it's acceesible in the erb etemplate
#   erb :name
# end

get "/"  do #specific routes go to the bottom, individual ones are on top, like if else statement
  puts params
  erb :contacts
end