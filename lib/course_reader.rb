# frozen_string_literal: true

require 'net/http'
require 'rexml/document'

class CourseReader
  attr_reader :date, :usd_rate, :eur_rate

  URL = 'http://www.cbr.ru/scripts/XML_daily.asp'

  def self.from_xml
    response = open_url(URL)
    doc = REXML::Document.new(response)
    usd_rate = doc.root.elements["Valute[@ID='R01235']"]
                  .elements['Value'].text.gsub(/,/, '.').to_f
    eur_rate = doc.root.elements["Valute[@ID='R01239']"]
                  .elements['Value'].text.gsub(/,/, '.').to_f
    date = doc.root.attributes['Date']
    new(
      date: date,
      usd_rate: usd_rate,
      eur_rate: eur_rate
    )
  end

  def initialize(args)
    @date = args[:date]
    @usd_rate = args[:usd_rate]
    @eur_rate = args[:eur_rate]
  end

  def print_courses
    puts "Курс валют на: #{@date}\n",
         "Курс доллара США: #{@usd_rate}\n",
         "Курс Евро: #{@eur_rate}\n\r"
  end

  def self.open_url(url)
    Net::HTTP.get(URI.parse(url))
  end
end
