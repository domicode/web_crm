require "sinatra"
require "sinatra/content_for"
require "data_mapper"
require_relative "rolodex"

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact

  include DataMapper::Resource 

  property :id, Serial #Set the values and also makes it an attr_accessor as well as initalize
  property :first_name, String
  property :last_name, String
  property :address, String
  property :postcode, String
  property :place, String 
  property :email, String
  property :notes, String

end

DataMapper.finalize #check if my inputs are valid, e.g. string = string 
DataMapper.auto_upgrade!




@@rolodex = Rolodex.new

get '/contacts/new' do
  erb :new_contact
end

post "/contacts" do 
  # puts params
  # new_contact = Contact.new(params[:first_name], params[:last_name], params[:address], params[:place], params[:postcode], params[:email], params[:notes])
  # @@rolodex.add_contact(new_contact)
  @contact = Contact.create
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    #etc
  redirect to('/contacts/a_z')
end

get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get "/contacts/a_z" do
  @@rolodex.sort
  @@rolodex
  erb :contacts_az
end


get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

get "/contacts/search" do
  erb :search
end

get "/search" do
    @contact = @@rolodex.search(params[:last_name])
  if @contact
    erb :show_contact
  else
    erb :search
  end
end


get "/contacts/:id" do #the :id will be transferred automattically through the params. :id can be a number, string whatever
  @contact =  Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do #update contact
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.address = params[:address]
    @contact.postcode = params[:postcode]
    @contact.place = params[:place]
    @contact.email = params[:email]
    @contact.notes = params[:notes]

    redirect to("contacts/a_z")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do #delete contact
  @contact = @@rolodex.find(params[:id].to_i)
  if @contact
    @@rolodex.remove_contact(@contact)
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

get "/"  do #specific routes go to the bottom, individual ones are on top, like if else statement
  puts params
  erb :contacts
end