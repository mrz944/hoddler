require 'binance'

class Api::Binance::ImportKlines < ApplicationService
  def initialize(ticker, interval='1d')
    @ticker = ticker
    @interval = interval
    @client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)
  end

  def call
    # first_day = (@ticker.trades.order(timestamp: :asc).first.timestamp - 14).to_time.to_i * 1000 # 14 days before first trade
    # imported_klines = @client.klines(symbol: @ticker.symbol, startTime: first_day, interval: @interval)
    imported_klines = @client.klines(symbol: @ticker.symbol, interval: @interval)

    klines = imported_klines.map do |k|
      date = Time.at(k[0]/1000).utc.to_date
      {
        timestamp: date,
        open:  k[1],
        high:  k[2],
        low:   k[3],
        close: k[4],
        ticker_id: @ticker.id
      }
    end

    Kline.create klines
  end
end
