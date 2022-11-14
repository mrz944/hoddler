json.time do
  json.year  kline.timestamp.year
  json.month kline.timestamp.month
  json.day   kline.timestamp.day
end
json.extract! kline, :open, :high, :low, :close
