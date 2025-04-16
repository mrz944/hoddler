trader = Trader.create!(
  api_key: 'PLACEHOLDER_API_KEY',
  api_secret: 'PLACEHOLDER_API_SECRET'
)

ticker = Ticker.create!(symbol: 'SOLUSDT', trader_id: trader.id)
ticker.import_trades
ticker.import_klines
ticker.generate_markers
ticker.update_stats


tickers = %w(SOLUSDT DOGEUSDT ICPUSDT RVNUSDT RUNEUSDT QIUSDT DATAUSDT ONEUSDT XECUSDT SUSHIUSDT)
tickers.each do |ticker|
  ticker = Ticker.create!(symbol: ticker, trader_id: trader.id)
  ticker.import_trades
  ticker.import_klines
  ticker.generate_markers
  ticker.update_stats
end