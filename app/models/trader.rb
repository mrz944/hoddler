class Trader
  include Mongoid::Document
  include Mongoid::Timestamps

  field :api_key,    type: String
  field :api_secret, type: String

  has_many :tickers, dependent: :destroy
end
