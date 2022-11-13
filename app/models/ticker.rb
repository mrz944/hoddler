class Ticker
  include Mongoid::Document
  include Mongoid::Timestamps

  field :symbol, type: String

  belongs_to :trader
  # TODO: use one set of klines for every user
  has_many :klines, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :trades, dependent: :destroy

  def import_trades
    Api::Binance::ImportTrades.call(self)
  end

  def import_klines
    Api::Binance::ImportKlines.call(self)
  end

  def generate_markers
    GenerateMarkers.call(self)
  end
end
