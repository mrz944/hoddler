class Marker
  include Mongoid::Document

  field :price,          type: BigDecimal
  field :quantity,       type: BigDecimal
  field :buy?,           type: Boolean
  field :timestamp,      type: DateTime

  belongs_to :ticker
end
