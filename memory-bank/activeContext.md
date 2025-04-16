# Active Context: Hoddler

## Current Work Focus

### Primary Focus Areas
1. **Cryptocurrency Portfolio Tracking**
   - Binance API integration for trade and price data
   - Visualization of trading history and performance
   - Calculation of portfolio statistics

2. **Chart Visualization**
   - Candlestick charts for price history
   - Trading markers for buy/sell points
   - Interactive UI for data exploration

3. **Data Processing**
   - Trade data aggregation and analysis
   - Performance metrics calculation
   - Daily trading activity summarization

### Recent Changes
- Implementation of core models (Trader, Ticker, Kline, Marker, Trade)
- Integration with Binance API for data retrieval
- Development of service objects for data processing
- Creation of chart visualization using Lightweight Charts

## Next Steps

### Immediate Priorities
1. **User Authentication**
   - Implement user accounts and authentication
   - Associate traders with specific users
   - Secure API credentials storage

2. **Enhanced Data Visualization**
   - Add more chart types and indicators
   - Implement time range selection
   - Improve marker visualization

3. **Portfolio Dashboard**
   - Create overview of all tickers
   - Implement portfolio-wide statistics
   - Add data refresh functionality

### Technical Improvements
1. **Performance Optimization**
   - Optimize MongoDB queries
   - Implement caching for API responses
   - Improve chart rendering performance

2. **Code Refactoring**
   - Share common code between services
   - Improve error handling
   - Add comprehensive testing

## Active Decisions and Considerations

### Architecture Decisions
1. **Service-Oriented Design**
   - Using service objects for business logic
   - Keeping controllers thin
   - Encapsulating API interactions

2. **MongoDB for Data Storage**
   - Document-oriented structure for flexible schema
   - Efficient storage of time-series data
   - Relationship management through references

3. **Frontend Approach**
   - Tailwind CSS for styling
   - Lightweight Charts for visualization
   - AJAX for dynamic data loading

### Current Challenges
1. **API Rate Limiting**
   - Managing Binance API request limits
   - Implementing efficient data fetching strategies
   - Handling API errors gracefully

2. **Data Consistency**
   - Ensuring accurate trade history
   - Maintaining data integrity across models
   - Handling edge cases in calculations

3. **UI Responsiveness**
   - Optimizing chart performance with large datasets
   - Improving loading states and feedback
   - Enhancing mobile experience

## Important Patterns and Preferences

### Code Organization
- Models define data structure and relationships
- Services handle business logic and API interactions
- Controllers coordinate requests and responses
- Views present data to users

### Naming Conventions
- Models: Singular nouns (Ticker, Trade)
- Controllers: Plural nouns (TickersController)
- Services: Action verbs (UpdateTicker, GenerateMarkers)
- Views: Match controller actions (show.html.erb)

### Data Flow Patterns
- User requests → Controller → Service → Model → Database
- API requests → Service → Model → Database
- Data retrieval → Model → Service → Controller → View

### Error Handling
- Service objects return success/failure status
- Controllers handle errors and provide feedback
- API errors are logged and handled gracefully

## Learnings and Project Insights

### Technical Insights
- MongoDB works well for time-series financial data
- Service objects provide clean separation of concerns
- Lightweight Charts offers good performance for financial visualization

### Process Improvements
- Implement more comprehensive error handling
- Add logging for API interactions
- Develop more robust testing strategy

### Future Considerations
- Scaling for multiple users and large portfolios
- Real-time updates using WebSockets
- Advanced analytics and trading insights
- Mobile application development
