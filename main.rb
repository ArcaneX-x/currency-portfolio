require 'net/http'
require 'rexml/document'
require_relative 'lib/portfolio'

URL = "http://www.cbr.ru/scripts/XML_daily.asp".freeze

response = Net::HTTP.get_response(URI.parse(URL))
doc = REXML::Document.new(response.body)
portfolio = Portfolio.from_xml(doc)
portfolio.print_courses

puts "Сколько у вас рублей?"
user_rub = STDIN.gets.to_f
puts "Сколько у вас долларов?"
user_usd = STDIN.gets.to_f
puts "Сколько у вас евро?"
user_eur = STDIN.gets.to_f
puts
portfolio.amount(user_rub:, user_usd:, user_eur:)
portfolio.calculate
