# Technical Context: Hoddler

## Technologies Used

### Backend Framework
- **Ruby on Rails 7.0.7**
  - Web application framework
  - MVC architecture
  - API endpoints for JSON data

### Database
- **MongoDB 4.x+**
  - Document-oriented NoSQL database
  - Flexible schema for cryptocurrency data
  - Accessed via Mongoid 8.0.2 ODM

### Frontend
- **Tailwind CSS**
  - Utility-first CSS framework
  - Responsive design components
  - Integrated with Rails via tailwindcss-rails gem

- **JavaScript**
  - ES6+ syntax
  - Import maps for module management
  - AJAX for asynchronous data loading

- **Lightweight Charts**
  - Financial charting library
  - Candlestick chart visualization
  - Custom markers for trade events

### API Integration
- **Binance API**
  - REST API for cryptocurrency data
  - Accessed via binance-connector-ruby gem
  - Endpoints for trades, klines, and pricing

### Development Tools
- **Ruby 3.2.2**
  - Language version
  - Modern syntax features

- **Bundler**
  - Dependency management
  - Gemfile for package declarations

- **Importmap Rails**
  - JavaScript module management
  - No build step required

- **Hotwire (Turbo & Stimulus)**
  - SPA-like experience
  - JavaScript framework integration

## Development Setup

### Prerequisites
- Ruby 3.2.2
- MongoDB 4.x+
- Node.js and Yarn (for Tailwind CSS)
- Binance API credentials

### Environment Configuration
- MongoDB connection settings in `config/mongoid.yml`
- Binance API credentials stored in Trader model
- Development server via `bin/dev` (Procfile.dev)

### Key Dependencies
```ruby
# Backend
gem 'rails', '~> 7.0.7'
gem 'mongoid', '~> 8.0.2'
gem 'binance-connector-ruby', '~> 1.3.0'
gem 'jbuilder'

# Frontend
gem 'tailwindcss-rails'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
```

## Technical Constraints

### Data Storage
- MongoDB document size limits (16MB per document)
- Efficient querying for time-series data (klines)
- Proper indexing for performance

### API Limitations
- Binance API rate limits
- API key permissions and security
- Data consistency across API calls

### Performance Considerations
- Chart rendering performance with large datasets
- Efficient data processing for statistics
- Pagination for large collections

### Security Requirements
- Secure storage of API credentials
- No client-side exposure of sensitive data
- Protection against CSRF and XSS attacks

## Tool Usage Patterns

### Database Interaction
```ruby
# Document creation
Kline.create klines

# Querying
@ticker = Ticker.includes(:klines, :markers).find(params[:id])

# Relationships
belongs_to :ticker
has_many :klines, dependent: :destroy
```

### API Interaction
```ruby
# Client initialization
@client = Binance::Spot.new(key: @ticker.trader.api_key, secret: @ticker.trader.api_secret)

# API calls
trades = @client.my_trades(symbol: @ticker.symbol)
imported_klines = @client.klines(symbol: @ticker.symbol, interval: @interval)
current_price = @client.avg_price(symbol: @ticker.symbol)
```

### Service Pattern
```ruby
# Service definition
class UpdateTicker < ApplicationService
  def initialize(ticker)
    @ticker = ticker
    # Setup
  end

  def call
    # Implementation
  end
end

# Service invocation
UpdateTicker.call(ticker)
# or via facade
ticker.update_stats
```

### JSON Building
```ruby
# JBuilder templates
json.extract! ticker, :id, :symbol, :stats, :created_at, :updated_at
json.klines ticker.klines, partial: 'klines/kline', as: :kline
```

### Frontend JavaScript
```javascript
// Chart initialization
const chart = createChart(container, {
  // Configuration
});

// Data loading
Rails.ajax({
  url: window.location.pathname + '.json',
  type: "get",
  success: function(data) {
    series.setData(data.klines);
    series.setMarkers(data.markers);
  }
})
```

## Development Workflow

### Data Flow
1. Create Trader with API credentials
2. Create Ticker with cryptocurrency symbol
3. Import trades and klines from Binance
4. Generate markers from trade data
5. Calculate and update statistics
6. Display data in UI with charts

### Testing Strategy
- Model validations and relationships
- Service object functionality
- API integration with VCR/WebMock
- Controller responses and JSON structure

### Deployment Considerations
- MongoDB hosting and connection
- Asset compilation for production
- Environment variables for configuration
- API key security in production
