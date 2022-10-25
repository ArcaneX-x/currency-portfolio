require '../lib/portfolio'

RSpec.describe Portfolio do
      let(:portfolio) do Portfolio.new(
                  date: nil,
                  usd_rate: 60,
                  eur_rate: 50
      )
      end

      describe '#calculate' do
          it 'returns data' do
            portfolio.amount(5000, 50, 70)
            expect(portfolio.calculate).to eq nil
          end
      end
end

