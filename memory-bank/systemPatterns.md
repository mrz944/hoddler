# System Patterns: Hoddler

## System Architecture

### Overview
Hoddler follows a service-oriented architecture within the Rails framework, using MongoDB as the database. The application is structured to separate concerns between data retrieval, processing, and presentation.

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│  Controllers    │────▶│    Services     │────▶│     Models      │
│                 │     │                 │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
        │                       │                       │
        ▼                       ▼                       ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│     Views       │     │   Binance API   │     │    MongoDB      │
│                 │     │                 │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### Key Components

#### 1. Models
- **Trader**: Stores API credentials and has many tickers
- **Ticker**: Represents a cryptocurrency symbol and contains statistics
- **Kline**: Stores candlestick data (OHLC) for chart visualization
- **Marker**: Represents significant trading events on the chart
- **Trade**: Records individual trading transactions

#### 2. Services
- **API Services**: Handle communication with Binance API
  - `ImportTrades`: Fetches and stores trade history
  - `ImportKlines`: Retrieves candlestick data
- **Processing Services**:
  - `GenerateMarkers`: Creates visual markers from trade data
  - `UpdateTicker`: Calculates and updates ticker statistics

#### 3. Controllers
- **TickersController**: Manages ticker CRUD operations and data display

#### 4. Views
- HTML/ERB templates for UI rendering
- JSON builders for API responses
- JavaScript components for interactive charts

## Design Patterns

### 1. Service Objects Pattern
The application uses the Service Objects pattern to encapsulate business logic and API interactions:

```ruby
class Api::Binance::ImportKlines < ApplicationService
  def initialize(ticker, interval = '1d')
    @ticker = ticker
    @interval = interval
    @client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)
  end

  def call
    # Implementation
  end
end
```

Services are invoked through a common interface:
```ruby
ticker.import_klines  # Calls Api::Binance::ImportKlines.call(ticker)
```

### 2. Document-Oriented Data Model
Using MongoDB's document-oriented structure for flexible schema:

```ruby
class Ticker
  include Mongoid::Document
  include Mongoid::Timestamps

  field :symbol, type: String
  field :stats, type: Hash

  belongs_to :trader
  has_many :klines, dependent: :destroy
  has_many :markers, dependent: :destroy
  has_many :trades, dependent: :destroy
end
```

### 3. Facade Pattern
The Ticker model acts as a facade, providing a simplified interface to complex subsystems:

```ruby
def import_trades
  Api::Binance::ImportTrades.call(self)
end

def import_klines
  Api::Binance::ImportKlines.call(self)
end

def generate_markers
  GenerateMarkers.call(self)
end

def update_stats
  UpdateTicker.call(self)
end
```

### 4. Builder Pattern
JBuilder templates construct complex JSON responses:

```ruby
# app/views/tickers/_ticker.json.jbuilder
json.extract! ticker, :id, :symbol, :stats, :created_at, :updated_at
json.url ticker_url(ticker, format: :json)
json.klines ticker.klines, partial: 'klines/kline', as: :kline
json.markers ticker.markers, partial: 'markers/marker', as: :marker
```

## Component Relationships

### Data Flow
1. **User Interaction**: User creates or selects a ticker
2. **Data Retrieval**: Services fetch data from Binance API
3. **Data Processing**: Services process and store data in MongoDB
4. **Data Presentation**: Controllers and views present data to the user

### Key Implementation Paths

#### Ticker Creation and Data Import
```
User → TickersController#create → Ticker.new → Ticker#save →
Ticker#import_trades → Ticker#import_klines → Ticker#generate_markers → Ticker#update_stats
```

#### Chart Visualization
```
User → TickersController#show → show.html.erb → ticker_show.js → 
crypto_chart.js → AJAX request → TickersController#show (JSON) → 
_ticker.json.jbuilder → _kline.json.jbuilder + _marker.json.jbuilder → 
Chart rendering
```

## Technical Decisions

### 1. MongoDB for Data Storage
- **Rationale**: Flexible schema for varying cryptocurrency data structures
- **Implementation**: Mongoid ODM for Rails integration

### 2. Service-Oriented Design
- **Rationale**: Separation of concerns, testability, and maintainability
- **Implementation**: ApplicationService base class with call method pattern

### 3. Lightweight Charts for Visualization
- **Rationale**: Efficient rendering of financial charts with markers
- **Implementation**: JavaScript integration with Rails JSON endpoints

### 4. Tailwind CSS for UI
- **Rationale**: Rapid UI development with utility-first approach
- **Implementation**: Rails Tailwind integration
