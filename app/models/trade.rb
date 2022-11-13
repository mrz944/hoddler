class Trade
  include Mongoid::Document

  field :symbol,         type: String
  field :price,          type: BigDecimal
  field :quantity,       type: BigDecimal
  field :quote_quantity, type: Float
  field :commision,      type: BigDecimal
  field :buyer?,         type: Boolean
  field :timestamp,      type: DateTime

  belongs_to :ticker
end
