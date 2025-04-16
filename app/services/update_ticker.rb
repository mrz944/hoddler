require 'binance'

class UpdateTicker < ApplicationService
  include TradeCalculations
  
  def initialize(ticker)
    @ticker = ticker
    @client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)
  end

  def call
    reduced = reduce_trades(@ticker.trades)
    current_price = @client.avg_price(symbol: @ticker.symbol)
    pnl = ((current_price[:price].to_f - reduced[:price]) / reduced[:price]).round(8)

    @ticker.stats = {
      current_price: current_price,
      balance: reduced[:quantity],
      mean_price: reduced[:price],
      pnl: pnl
    }
    @ticker.save
  end

end
