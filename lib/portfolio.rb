class Portfolio

  def self.from_xml(node)
    usd_rate = node.root.elements["Valute[@ID='R01235']"]
                   .elements['Value'].text.gsub(/,/, '.').to_f
    eur_rate = node.root.elements["Valute[@ID='R01239']"]
                   .elements['Value'].text.gsub(/,/, '.').to_f
    date = node.root.attributes['Date']
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

  def amount(balance)
    @user_rub = balance[:user_rub]
    @user_usd = balance[:user_usd]
    @user_eur = balance[:user_eur]
  end

  def print_courses
    puts "Курс валют на: #{@date}\n",
         "Курс доллара США: #{@usd_rate}\n",
         "Курс Евро: #{@eur_rate}\n\r"
  end

  def calculate
    balance_usd = @user_rub - (@user_usd * @usd_rate)
    balance_eur = @user_rub - (@user_eur * @eur_rate)
    if balance_eur > balance_usd
      balance_eur -= balance_usd
      difference_eur = (balance_eur / @eur_rate)
      balance_eur = (@user_rub - ((@user_eur + difference_eur) * @eur_rate)) / @eur_rate
      difference_eur += balance_eur
      difference_usd = (balance_usd / @usd_rate)
    else
      balance_usd -= balance_eur
      difference_usd = (balance_usd / @usd_rate)
      balance_usd = (@user_rub - ((@user_usd + difference_usd) * @usd_rate)) / @usd_rate
      difference_usd += balance_usd
      difference_eur = (balance_eur / @eur_rate)
    end
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
