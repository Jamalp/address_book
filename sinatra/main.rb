require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry'
require 'rainbow'

get '/' do
  erb :index
end

# shows all contacts
get '/contacts' do
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * FROM contacts"
  @contacts = db.exec(sql)
  db.close
  erb :contacts
end

post '/contacts' do
  first = params[:first]
  last = params[:last]
  age = params[:age]
  gender = params[:gender]
  dtgd = params[:dtgd]
  sql = "Insert into contacts(first, last, age, gender, dtgd) VALUES ('#{first}', '#{last}', #{age}, '#{gender}', '#{dtgd}')"
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  db.exec(sql)
  db.close
  redirect to '/contacts'
end

# make a new contact
get '/contacts/form' do

 erb :form
end

# show one specific contact
get '/contacts/:name' do
  @user_name = params[:name]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * FROM contacts WHERE first = '#{@user_name}'"
  @contact = db.exec(sql).first
  db.close
  erb :contact
end

