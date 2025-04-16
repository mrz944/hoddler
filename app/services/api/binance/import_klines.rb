require 'binance'

class Api::Binance::ImportKlines < ApplicationService
  def initialize(ticker, interval = '1d')
    super()
    @ticker = ticker
    @interval = interval
    @client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)
  end

  def call
    Rails.logger.info("Importing klines for ticker #{@ticker.symbol} with interval #{@interval}")
    
    begin
      # 14 days before first trade
      # first_day = (@ticker.trades.order(timestamp: :asc).first.timestamp - 14).to_time.to_i * 1000
      # imported_klines = @client.klines(symbol: @ticker.symbol, startTime: first_day, interval: @interval)
      
      Rails.logger.debug("Fetching klines from Binance API for #{@ticker.symbol}")
      imported_klines = @client.klines(symbol: @ticker.symbol, interval: @interval)
      
      if imported_klines.empty?
        return add_error("No klines data returned from Binance for #{@ticker.symbol}")
      end
      
      Rails.logger.debug("Processing #{imported_klines.size} klines for #{@ticker.symbol}")
      klines = imported_klines.map do |k|
        begin
          date = Time.at(k[0] / 1000).utc.to_date
          {
            timestamp: date,
            open: k[1],
            high: k[2],
            low: k[3],
            close: k[4],
            ticker_id: @ticker.id
          }
        rescue StandardError => e
          Rails.logger.error("Error processing kline: #{e.message}")
          nil
        end
      end.compact
      
      if klines.empty?
        return add_error("Failed to process any klines for #{@ticker.symbol}")
      end
      
      Rails.logger.debug("Creating #{klines.size} klines for #{@ticker.symbol}")
      created_klines = Kline.create(klines)
      
      if created_klines.all?(&:persisted?)
        Rails.logger.info("Successfully created #{created_klines.size} klines for #{@ticker.symbol}")
        true
      else
        failed = created_klines.reject(&:persisted?)
        add_error("Failed to create #{failed.size} klines: #{failed.map { |k| k.errors.full_messages }.flatten.join(', ')}")
      end
    rescue Binance::Error => e
      Rails.logger.error("Binance API error in ImportKlines: #{e.message}")
      add_error("Binance API error: #{e.message}")
    rescue StandardError => e
      Rails.logger.error("Error in ImportKlines: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      add_error("Unexpected error: #{e.message}")
    end
  end
end
