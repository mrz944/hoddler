class Ticker
  include Mongoid::Document
  include Mongoid::Timestamps

  field :symbol, type: String
  field :stats, type: Hash

  belongs_to :trader
  # TODO: use one set of klines for every user
  has_many :klines, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :trades, dependent: :destroy

  # Returns service instance for error checking
  def import_trades
    service = Api::Binance::ImportTrades.new(self)
    result = service.call
    Rails.logger.error("Failed to import trades: #{service.errors.join(', ')}") unless result
    result
  end

  # Returns service instance for error checking
  def import_klines
    service = Api::Binance::ImportKlines.new(self)
    result = service.call
    Rails.logger.error("Failed to import klines: #{service.errors.join(', ')}") unless result
    result
  end

  # Returns service instance for error checking
  def generate_markers
    service = GenerateMarkers.new(self)
    result = service.call
    Rails.logger.error("Failed to generate markers: #{service.errors.join(', ')}") unless result
    result
  end

  # Returns service instance for error checking
  def update_stats
    service = UpdateTicker.new(self)
    result = service.call
    Rails.logger.error("Failed to update stats: #{service.errors.join(', ')}") unless result
    result
  end
end
