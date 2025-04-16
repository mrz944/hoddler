# Project Brief: Hoddler

## Overview
Hoddler is a cryptocurrency portfolio tracking application that integrates with the Binance API to provide users with real-time data about their cryptocurrency trades and investments. The application allows users to track multiple cryptocurrencies, visualize price movements through candlestick charts, and analyze their trading performance.

## Core Requirements

### Functional Requirements
1. **Binance API Integration**
   - Connect to Binance using API keys
   - Fetch user's trade history
   - Retrieve candlestick (kline) data for cryptocurrencies
   - Get current price information

2. **Portfolio Tracking**
   - Track multiple cryptocurrency tickers
   - Calculate and display portfolio statistics
   - Show profit/loss metrics

3. **Data Visualization**
   - Display interactive candlestick charts
   - Mark buy/sell points on charts
   - Show daily trading activity

4. **Data Management**
   - Store historical trade data
   - Maintain candlestick data for analysis
   - Generate trading markers for significant events

### Technical Requirements
1. **Architecture**
   - Rails 7 application
   - MongoDB for data storage
   - Service-oriented design for API interactions

2. **Performance**
   - Efficient data retrieval from Binance API
   - Optimized database queries
   - Responsive UI for chart rendering

3. **Security**
   - Secure storage of API credentials
   - No exposure of sensitive data in frontend

## Project Goals
1. Provide cryptocurrency traders with a comprehensive view of their trading activity
2. Enable data-driven trading decisions through visual analysis
3. Simplify portfolio tracking across multiple cryptocurrencies
4. Create an intuitive interface for monitoring trading performance

## Success Metrics
1. Accurate representation of user's trading history
2. Precise calculation of portfolio statistics
3. Real-time updates of cryptocurrency prices
4. Responsive and interactive chart visualization
