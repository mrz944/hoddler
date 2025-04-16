require 'binance'

class UpdateTicker < ApplicationService
  include TradeCalculations
  
  def initialize(ticker)
    super()
    @ticker = ticker
    @client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)
  end

  def call
    Rails.logger.info("Updating stats for ticker #{@ticker.symbol}")
    
    begin
      if @ticker.trades.empty?
        return add_error("No trades found for ticker #{@ticker.symbol}")
      end
      
      reduced = reduce_trades(@ticker.trades)
      
      Rails.logger.debug("Fetching current price for #{@ticker.symbol}")
      current_price = @client.avg_price(symbol: @ticker.symbol)
      
      # Handle potential division by zero
      pnl = if reduced[:price].zero?
        0
      else
        ((current_price[:price].to_f - reduced[:price]) / reduced[:price]).round(8)
      end

      @ticker.stats = {
        current_price: current_price,
        balance: reduced[:quantity],
        mean_price: reduced[:price],
        pnl: pnl
      }
      
      if @ticker.save
        Rails.logger.info("Successfully updated stats for #{@ticker.symbol}")
        true
      else
        add_error("Failed to save ticker: #{@ticker.errors.full_messages.join(', ')}")
      end
    rescue Binance::Error => e
      Rails.logger.error("Binance API error in UpdateTicker: #{e.message}")
      add_error("Binance API error: #{e.message}")
    rescue StandardError => e
      Rails.logger.error("Error in UpdateTicker: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      add_error("Unexpected error: #{e.message}")
    end
  end
end
