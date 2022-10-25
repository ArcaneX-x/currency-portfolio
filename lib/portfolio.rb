# frozen_string_literal: true

class Portfolio
  URL = 'http://www.cbr.ru/scripts/XML_daily.asp'
  def self.from_xml
    response = Net::HTTP.get_response(URI.parse(URL))
    doc = REXML::Document.new(response.body)

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

  def initialize(params)
    @date = params[:date]
    @usd_rate = params[:usd_rate]
    @eur_rate = params[:eur_rate]
  end

  def amount(user_rub, user_usd, user_eur)
    @user_rub = user_rub
    @user_usd = user_usd
    @user_eur = user_eur
  end

  def print_courses
    puts "Курс валют на: #{@date}\n",
         "Курс доллара США: #{@usd_rate}\n",
         "Курс Евро: #{@eur_rate}\n\r"
  end

  def calculate
    balance_usd = @user_rub - (@user_usd * @usd_rate)
    balance_eur = @user_rub - (@user_eur * @eur_rate)

    difference_eur = (balance_eur / @eur_rate)
    balance_eur = (@user_rub / @eur_rate) - (@user_eur + difference_eur)
    difference_eur += balance_eur

    difference_usd = (balance_usd / @usd_rate)
    balance_usd = (@user_rub / @usd_rate) - (@user_usd + difference_usd)
    difference_usd += balance_usd

    to_s(difference_eur.round(2), difference_usd.round(2))
  end

  def to_s(difference_eur, difference_usd)
    if difference_eur.positive? then puts "Вам нужно купить: #{difference_eur} EUR"
    else
      puts "Вам нужно продать: #{difference_eur.abs} EUR"
    end
    if difference_usd.positive? then puts "Вам нужно купить: #{difference_usd} USD"
    else
      puts "Вам нужно продать: #{difference_usd.abs} USD"
    end
  end
end
