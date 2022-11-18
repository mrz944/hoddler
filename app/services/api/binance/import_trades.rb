require 'binance'

class Api::Binance::ImportTrades < ApplicationService
  def initialize(ticker)
    @ticker = ticker
    @client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)
  end

  def call
    trades = @client.my_trades(symbol: @ticker.symbol).map do |t|
      {
        price: t[:price].to_f,
        quantity: t[:qty].to_f,
        quote_quantity: t[:quoteQty].to_f,
        commision: t[:commission].to_f,
        buyer?: t[:isBuyer],
        timestamp: Time.at(t[:time] / 1000).utc.to_datetime,
        ticker_id: @ticker.id
      }
    end

    Trade.create trades
  end
end
