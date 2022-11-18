json.extract! ticker, :id, :symbol, :stats, :created_at, :updated_at
json.url ticker_url(ticker, format: :json)
json.klines ticker.klines, partial: 'klines/kline', as: :kline
json.markers ticker.markers, partial: 'markers/marker', as: :marker
