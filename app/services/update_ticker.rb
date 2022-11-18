require 'binance'

class UpdateTicker < ApplicationService
  def initialize(ticker)
    @ticker = ticker
    @client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)
  end

  def call
    reduced = reduce_trades(@ticker.trades)
    current_price = @client.avg_price(symbol: @ticker.symbol)
    pnl = (current_price[:price].to_f - reduced[:price]) / reduced[:price]

    @ticker.stats = {
      current_price: current_price,
      balance: reduced[:quantity],
      mean_price: reduced[:price],
      pnl: pnl
    }
    @ticker.save
  end

  private

  def reduce_trades(trades)
    # TODO: share function with GenerateMarkers
    bought = trades.filter { |t| t[:buyer?] }
    sold = trades.filter { |t| !t[:buyer?] }

    quote = {
      bought: bought.map { |x| x[:quote_quantity] }.sum,
      sold: sold.map { |x| x[:quote_quantity] }.sum
    }
    quantity = {
      bought: bought.map { |x| x[:quantity] }.sum,
      sold: sold.map { |x| x[:quantity] }.sum
    }

    total_quantity = quantity[:bought] - quantity[:sold]
    mean_price = (quote[:bought] - quote[:sold]) / total_quantity

    {
      quantity: total_quantity.round(8),
      price: mean_price.round(8)
    }
  end
end
