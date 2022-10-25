require 'net/http'
require 'rexml/document'
require_relative 'lib/portfolio'

portfolio = Portfolio.from_xml
portfolio.print_courses

puts "Давайте создадим бивалютный порфтель:"

puts "Сколько у вас рублей?"
user_rub = STDIN.gets.to_f
puts "Сколько у вас долларов?"
user_usd = STDIN.gets.to_f
puts "Сколько у вас евро?"
user_eur = STDIN.gets.to_f
puts

if user_usd <= 10 && user_eur <= 10 && user_rub <= 1000
  abort 'Вы походу бомжара...'
end

portfolio.amount(user_rub, user_usd, user_eur)
portfolio.calculate
