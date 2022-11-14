class GenerateMarkers < ApplicationService
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    trading_days = @ticker.trades.map { |t| t[:timestamp].to_date }.uniq

    markers = trading_days.map do |day|
      day_trades = @ticker.trades.filter { |t| t[:timestamp].to_date == day }

      reduced = reduce_trades(day_trades)

      {
        price:     reduced[:price],
        quantity:  reduced[:quantity],
        buy?:      reduced[:quantity].positive?,
        timestamp: day,
        ticker_id: @ticker.id
      }
    end

    Marker.create markers
  end

  private

  def reduce_trades(trades)
    bought = trades.filter { |t| t[:buyer?] }
    sold   = trades.filter { |t| !t[:buyer?] }

    quote = {
      bought: bought.map { |x| x[:quote_quantity] }.sum,
      sold:   sold.map { |x| x[:quote_quantity] }.sum
    }
    quantity = {
      bought: bought.map { |x| x[:quantity] }.sum,
      sold:   sold.map { |x| x[:quantity] }.sum
    }

    total_quantity = quantity[:bought] - quantity[:sold]
    mean_price = (quote[:bought] - quote[:sold]) / total_quantity

    { 
      quantity: total_quantity.round(8),
      price: mean_price.round(8)
    }
  end
end
