Rails.logger.info("Creating trader with API credentials")

# Use environment variables for API credentials
# In production, set these in your environment or use Rails credentials
api_key = ENV['BINANCE_API_KEY'] || 'demo_api_key'
api_secret = ENV['BINANCE_API_SECRET'] || 'demo_api_secret'

trader = Trader.create!(
  api_key: api_key,
  api_secret: api_secret
)

Rails.logger.info("Creating initial SOLUSDT ticker")
ticker = Ticker.create!(symbol: 'SOLUSDT', trader_id: trader.id)

Rails.logger.info("Importing data for SOLUSDT")
if ticker.import_trades
  Rails.logger.info("Successfully imported trades for SOLUSDT")
else
  Rails.logger.error("Failed to import trades for SOLUSDT")
end

if ticker.import_klines
  Rails.logger.info("Successfully imported klines for SOLUSDT")
else
  Rails.logger.error("Failed to import klines for SOLUSDT")
end

if ticker.generate_markers
  Rails.logger.info("Successfully generated markers for SOLUSDT")
else
  Rails.logger.error("Failed to generate markers for SOLUSDT")
end

if ticker.update_stats
  Rails.logger.info("Successfully updated stats for SOLUSDT")
else
  Rails.logger.error("Failed to update stats for SOLUSDT")
end

Rails.logger.info("Creating additional tickers")
tickers = %w(DOGEUSDT ICPUSDT RVNUSDT RUNEUSDT QIUSDT DATAUSDT ONEUSDT XECUSDT SUSHIUSDT)
tickers.each do |symbol|
  Rails.logger.info("Processing ticker: #{symbol}")
  begin
    ticker = Ticker.create!(symbol: symbol, trader_id: trader.id)
    
    Rails.logger.info("Importing data for #{symbol}")
    ticker.import_trades
    ticker.import_klines
    ticker.generate_markers
    ticker.update_stats
    
    Rails.logger.info("Successfully processed #{symbol}")
  rescue StandardError => e
    Rails.logger.error("Error processing #{symbol}: #{e.message}")
  end
end

Rails.logger.info("Seed data creation completed")
