# frozen_string_literal: true

require '../lib/portfolio'
require '../lib/course_reader'
require 'byebug'

describe Portfolio do
  describe '.new' do
    let(:courses) { CourseReader.new(date: '28.10.2022', usd_rate: 60, eur_rate: 70) }

    it 'should be Portfolio class' do
      portfolio = described_class.new(
        courses: courses,
        user_rub: 3000,
        user_usd: 50,
        user_eur: 50
      )
      expect(portfolio).to be_an Portfolio
    end

    it 'should be Portfolio class' do
      portfolio = described_class.new(
        courses: courses,
        user_rub: 5000.to_f,
        user_usd: 50.to_f,
        user_eur: 100.to_f
      )
      expect(portfolio.calculate).to match [-28.57, 33.33]
    end
  end
end
