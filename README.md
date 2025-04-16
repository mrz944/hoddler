# Hoddler - Cryptocurrency Portfolio Tracker

![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red)
![Rails](https://img.shields.io/badge/Rails-7.0.7-red)
![MongoDB](https://img.shields.io/badge/MongoDB-4.x-green)
![License](https://img.shields.io/badge/license-MIT-blue)

Hoddler is a cryptocurrency portfolio tracking application that integrates with the Binance API to provide users with real-time data about their cryptocurrency trades and investments. The application allows users to track multiple cryptocurrencies, visualize price movements through candlestick charts, and analyze their trading performance.

![Hoddler Screenshot](docs/screenshot.png)

## Features

- **Binance API Integration**
  - Connect to Binance using API keys
  - Fetch user's trade history
  - Retrieve candlestick (kline) data for cryptocurrencies
  - Get current price information

- **Portfolio Tracking**
  - Track multiple cryptocurrency tickers
  - Calculate and display portfolio statistics
  - Show profit/loss metrics

- **Data Visualization**
  - Display interactive candlestick charts
  - Mark buy/sell points on charts
  - Show daily trading activity

- **Data Management**
  - Store historical trade data
  - Maintain candlestick data for analysis
  - Generate trading markers for significant events

## Tech Stack

- **Backend**: Ruby on Rails 7.0.7
- **Database**: MongoDB 4.x+ with Mongoid 8.0.2
- **Frontend**: Tailwind CSS, JavaScript, Lightweight Charts
- **API**: Binance API via binance-connector-ruby

## Architecture

Hoddler follows a service-oriented architecture within the Rails framework:

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

## Prerequisites

- Ruby 3.2.2
- MongoDB 4.x+
- Node.js and Yarn (for Tailwind CSS)
- Binance API credentials

## Installation

1. Clone the repository
   ```bash
   git clone https://github.com/mrz944/hoddler.git
   cd hoddler
   ```

2. Install dependencies
   ```bash
   bundle install
   ```

3. Configure MongoDB
   - Update `config/mongoid.yml` with your MongoDB connection settings

4. Set up environment variables
   - Create a `.env` file in the root directory
   - Add your Binance API credentials (see `.env.example`)

5. Initialize the database
   ```bash
   rails db:seed
   ```

6. Start the server
   ```bash
   bin/dev
   ```

7. Visit `http://localhost:3000` in your browser

## Usage

### Adding a Trader with API Credentials

1. Create a new trader with your Binance API credentials
2. The system will automatically fetch your trading history

### Adding Cryptocurrency Tickers

1. Navigate to the "Add Ticker" page
2. Enter the cryptocurrency symbol (e.g., BTCUSDT, ETHUSDT)
3. The system will import trades, klines, and generate markers

### Viewing Charts and Statistics

1. Select a ticker from your dashboard
2. View the candlestick chart with your trading markers
3. Check the statistics panel for performance metrics

## Development

### Service Architecture

Hoddler uses a service-oriented design pattern:

- **API Services**: Handle communication with Binance API
  - `ImportTrades`: Fetches and stores trade history
  - `ImportKlines`: Retrieves candlestick data
  
- **Processing Services**:
  - `GenerateMarkers`: Creates visual markers from trade data
  - `UpdateTicker`: Calculates and updates ticker statistics

### Running Tests

```bash
rails test
```

## Roadmap

- [ ] User authentication and authorization
- [ ] Portfolio dashboard with overview of all tickers
- [ ] Enhanced chart visualization with technical indicators
- [ ] Real-time updates using WebSockets
- [ ] Mobile optimization

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Binance API](https://github.com/binance/binance-connector-ruby) for cryptocurrency data
- [Lightweight Charts](https://github.com/tradingview/lightweight-charts) for chart visualization
- [Tailwind CSS](https://tailwindcss.com/) for styling
