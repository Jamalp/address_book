require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra-reloader'


puts  "hey girl, what's yo first name??"
@first = gets.chomp

puts  "hey girl, what's yo last name??"
@last = gets.chomp

puts "hey girl hey, give me your age. Ain't lookin for no Jail Bait"
@age = gets.chomp

puts "hey girl hey..hey. No judgement, but whats your gender?"
@gender = gets.chomp

puts "Yo, I'm really lookin for someone who can get down, is that you? Tell me thats true and not false."
@dtgd = gets.chomp

puts "Aight cool cool, You're lookin good, throw me yo numbah"
@phone = gets.chomp

puts "PS.....The back of yo head is ridiculous!"


# This establishes a connection to the databse
db = PG.connect(:dbname => 'address_book',
                :host => 'localhost')
# executing SQL code.
# Passing a string of sql to the Database
# db.exec( "insert into contacts(first, last, age, gender, dtgd, phone) VALUES ('Michael', 'Jackson', 50, 'M', False, '111-111-1111'); ") do |result|
#   result.each do |row|
#     binding.pry
#   end
# end

sql =  "insert into contacts(first, last, age, gender, dtgd, phone) VALUES ('#{@first}', '#{@last}', #{@age}, '#{@gender}', #{@dtgd}, '#{@phone}')"
db.exec(sql)

db.close

db = PG.connect(:dbname => 'address_book',
                :host => 'localhost')
show =  db.exec("select * from contacts")
 show.each do |row|
  puts row
end
db.close



