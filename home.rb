require "sinatra"
require "sinatra/content_for"
require "data_mapper"
require_relative "rolodex"
require "debugger"
require 'dm-timestamps'

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
  property :notes, Text
  property :created_on, Date

end

DataMapper.finalize #check if my inputs are valid, e.g. string = string 
DataMapper.auto_upgrade!




get '/contacts/new' do
  erb :new_contact
end

post "/contacts" do 
  # puts params
  # new_contact = Contact.new(params[:first_name], params[:last_name], params[:address], params[:place], params[:postcode], params[:email], params[:notes])
  # @@rolodex.add_contact(new_contact)
  @contact = Contact.create(
    :first_name => params[:first_name].capitalize,
    :last_name => params[:last_name].capitalize,
    :address => params[:address].capitalize, 
    :place => params[:place].capitalize, 
    :postcode => params[:postcode], 
    :email => params[:email], 
    :notes => params[:notes]
    )
  redirect to('/contacts/a_z')
end

get "/contacts" do
  @contacts = Contact.all
  erb :contacts
end

get "/contacts/a_z" do
  @contacts = Contact.all(:order => [:last_name.asc])
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

get "/order" do
  @contacts = Contact.all(:order => [:"#{params[:order]}".asc])
  erb :contacts_az
end

get "/orderfull" do
  @contacts = Contact.all(:order => [:"#{params[:order]}".asc])
  erb :contacts
end


get "/search" do

    # @contact = 
    # Contact.all(:last_name.like => params[:last_name] +
    #             :first_name.like => params[:last_name])

@term = params[:term]
@results = Contact.all(:id.like => @term) +
           Contact.all(:first_name.like => "%"+@term+"%") +
           Contact.all(:last_name.like => "%"+@term+"%") +
           Contact.all(:address.like => "%"+@term+"%") +
           Contact.all(:postcode.like => "%"+@term+"%") +
           Contact.all(:place.like => "%"+@term+"%") +
           Contact.all(:email.like => "%"+@term+"%") +
           Contact.all(:notes.like => "%"+@term+"%") 
  if @results
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
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name].capitalize
    @contact.last_name = params[:last_name].capitalize
    @contact.address = params[:address].capitalize
    @contact.postcode = params[:postcode]
    @contact.place = params[:place].capitalize
    @contact.email = params[:email]
    @contact.notes = params[:notes]
    @contact.save
    redirect to("contacts/a_z")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do #delete contact
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

get "/"  do #specific routes go to the bottom, individual ones are on top, like if else statement
  @contacts = Contact.all
  erb :contacts
end