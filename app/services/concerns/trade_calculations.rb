module TradeCalculations
  def reduce_trades(trades)
    bought = trades.filter { |t| t[:buyer?] }
    sold = trades.filter { |t| !t[:buyer?] }

    quote = {
      bought: bought.map { |x| x[:quote_quantity] }.sum,
      sold: sold.map { |x| x[:quote_quantity] }.sum
    }
    quantity = {
      bought: bought.map { |x| x[:quantity] }.sum,
      sold: sold.map { |x| x[:quantity] }.sum
    }

    total_quantity = quantity[:bought] - quantity[:sold]
    mean_price = (quote[:bought] - quote[:sold]) / total_quantity

    {
      quantity: total_quantity.round(8),
      price: mean_price.round(8)
    }
  end
end
