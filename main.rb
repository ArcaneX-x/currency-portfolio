require 'net/http'
require 'rexml/document'
require_relative 'lib/portfolio'

portfolio = Portfolio.from_xml
portfolio.print_courses

puts "Сколько у вас рублей?"
user_rub = STDIN.gets.to_f
puts "Сколько у вас долларов?"
user_usd = STDIN.gets.to_f
puts "Сколько у вас евро?"
user_eur = STDIN.gets.to_f
puts

if user_usd && user_eur && user_rub <= 0
  puts "Вы походу бомжара..."
  abort
end

portfolio.amount(user_rub, user_usd, user_eur)
portfolio.calculate
