require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra-reloader'



get '/form' do


erb :form
end

get '/'
# This establishes a connection to the databse

  person = []
  db = PG.connect(:dbname => 'address_book',
                  :host => 'localhost')
 db.exec("select * from contacts") do |result|
      result.each do |row|
        @person << row
      end
    end
  db.close
  erb :new_person

get '/contacts/:name' do
  @name = params[:name]
  db = PG.connect(:dbname => 'address_book', host => 'localhost')
  sql = "select * from contacts where first = #{name}"
  @contact = db.exec(sql).first
  db.close

  erb :contact
end



  # executing SQL code.
  # Passing a string of sql to the Database
  # db.exec( "insert into contacts(first, last, age, gender, dtgd, phone) VALUES ('Michael', 'Jackson', 50, 'M', False, '111-111-1111'); ") do |result|
  #   result.each do |row|
  #     binding.pry
  #   end
  # end

#   sql =  "insert into contacts(first, last, age, gender, dtgd, phone) VALUES ('#{@first}', '#{@last}', #{@age}, '#{@gender}', #{@dtgd}, '#{@phone}')"
#   db.exec(sql)

#   db.close

#   db = PG.connect(:dbname => 'address_book',
#                   :host => 'localhost')
#   show =  db.exec("select * from contacts")
#    show.each do |row|
#     puts row
#   end
#   db.close

#   erb :form
# end

