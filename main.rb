# frozen_string_literal: true

require_relative 'lib/portfolio'
require_relative 'lib/course_reader'
require 'byebug'

courses = CourseReader.from_xml
courses.print_courses
puts 'Давайте создадим бивалютный порфтель:'

puts 'Сколько у вас рублей?'
user_rub = $stdin.gets.to_f
puts 'Сколько у вас долларов?'
user_usd = $stdin.gets.to_f
puts 'Сколько у вас евро?'
user_eur = $stdin.gets.to_f

portfolio = Portfolio.new(courses: courses, user_rub: user_rub,
                          user_eur: user_eur, user_usd: user_usd)

if user_usd <= 10 && user_eur <= 10 && user_rub <= 1000
  abort 'Вы походу бомжара...'
end

portfolio.print_result
