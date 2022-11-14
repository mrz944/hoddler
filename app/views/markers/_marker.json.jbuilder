json.time do
  json.year  marker.timestamp.year
  json.month marker.timestamp.month
  json.day   marker.timestamp.day
end
json.position marker.buy? ? 'belowBar' : 'aboveBar'
json.color    marker.buy? ? '#b4d273' : '#b05279'
json.shape    marker.buy? ? 'arrowUp' : 'arrowDown'
json.text     "#{marker.buy? ? 'Buy' : 'Sell'} #{marker.quantity} @ #{marker.price}"
