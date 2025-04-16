class GenerateMarkers < ApplicationService
  include TradeCalculations
  
  def initialize(ticker)
    @ticker = ticker
  end

  def call
    trading_days = @ticker.trades.map { |t| t[:timestamp].to_date }.uniq

    markers = trading_days.map do |day|
      day_trades = @ticker.trades.filter { |t| t[:timestamp].to_date == day }

      reduced = reduce_trades(day_trades)

      {
        price: reduced[:price],
        quantity: reduced[:quantity],
        buy?: reduced[:quantity].positive?,
        timestamp: day,
        ticker_id: @ticker.id
      }
    end

    Marker.create markers
  end

end
