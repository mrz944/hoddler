class Kline
  include Mongoid::Document

  field :timestamp, type: DateTime
  field :open,      type: Float
  field :high,      type: Float
  field :low,       type: Float
  field :close,     type: Float

  belongs_to :ticker
end
