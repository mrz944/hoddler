require 'binance'

class Api::Binance::ImportTrades < ApplicationService
  def initialize(ticker)
    super()
    @ticker = ticker
    @client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)
  end

  def call
    Rails.logger.info("Importing trades for ticker #{@ticker.symbol}")
    
    begin
      Rails.logger.debug("Fetching trades from Binance API for #{@ticker.symbol}")
      api_trades = @client.my_trades(symbol: @ticker.symbol)
      
      if api_trades.empty?
        return add_error("No trades found for #{@ticker.symbol}")
      end
      
      Rails.logger.debug("Processing #{api_trades.size} trades for #{@ticker.symbol}")
      trades = api_trades.map do |t|
        begin
          {
            price: t[:price].to_f,
            quantity: t[:qty].to_f,
            quote_quantity: t[:quoteQty].to_f,
            commision: t[:commission].to_f,
            buyer?: t[:isBuyer],
            timestamp: Time.at(t[:time] / 1000).utc.to_datetime,
            ticker_id: @ticker.id
          }
        rescue StandardError => e
          Rails.logger.error("Error processing trade: #{e.message}")
          nil
        end
      end.compact
      
      if trades.empty?
        return add_error("Failed to process any trades for #{@ticker.symbol}")
      end
      
      Rails.logger.debug("Creating #{trades.size} trades for #{@ticker.symbol}")
      created_trades = Trade.create(trades)
      
      if created_trades.all?(&:persisted?)
        Rails.logger.info("Successfully created #{created_trades.size} trades for #{@ticker.symbol}")
        true
      else
        failed = created_trades.reject(&:persisted?)
        add_error("Failed to create #{failed.size} trades: #{failed.map { |t| t.errors.full_messages }.flatten.join(', ')}")
      end
    rescue Binance::Error => e
      Rails.logger.error("Binance API error in ImportTrades: #{e.message}")
      add_error("Binance API error: #{e.message}")
    rescue StandardError => e
      Rails.logger.error("Error in ImportTrades: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      add_error("Unexpected error: #{e.message}")
    end
  end
end
