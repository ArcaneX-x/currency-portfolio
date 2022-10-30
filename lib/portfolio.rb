# frozen_string_literal: true

require_relative 'course_reader'
class Portfolio
  def initialize(args)
    @date = args[:courses].date
    @usd_rate = args[:courses].usd_rate
    @eur_rate = args[:courses].eur_rate
    @user_rub = args[:user_rub]
    @user_usd = args[:user_usd]
    @user_eur = args[:user_eur]
  end

  def print_result
    eur = calculate[0]
    usd = calculate[1]
    if eur.positive? then puts "Вам нужно купить: #{eur} EUR"
    else
      puts "Вам нужно продать: #{eur.abs} EUR"
    end
    if usd.positive? then puts "Вам нужно купить: #{usd} USD"
    else
      puts "Вам нужно продать: #{usd.abs} USD"
    end
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
    [difference_eur.round(2), difference_usd.round(2)]
  end
end
