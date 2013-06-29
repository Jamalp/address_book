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

post '/contacts/:id/delete' do
  id = params[:id]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "DELETE FROM contacts WHERE id = #{id}"
  @contact = db.exec(sql).first
  db.close
  redirect to '/contacts'
end

get '/contacts/:id/edit' do
  id = params[:id]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * FROM contacts WHERE id = #{id}"
  @contact = db.exec(sql).first
  db.close
  erb :edit
end

# make a new contact
get '/contacts/form' do

 erb :form
end

# show one specific contact
get '/contacts/:id' do
  @id = params[:id]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "SELECT * FROM contacts WHERE id = #{@id}"
  @contact = db.exec(sql).first
  db.close
  erb :contact
end

post '/contact/:id' do
  id = params[:id]
  first = params[:first]
  last = params[:last]
  age = params[:age]
  gender = params[:gender]
  dtgd = params[:dtgd]
  phone = params[:phone]
  db = PG.connect(:dbname => 'address_book', :host => 'localhost')
  sql = "UPDATE contacts SET (first, last, age, gender, dtgd, phone) = ('#{first}', '#{last}', #{age}, '#{gender}', '#{dtgd}', '#{phone}') WHERE id = #{id}"
    db.exec(sql).first
    redirect to '/contacts'
end
