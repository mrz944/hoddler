# Contributing to Hoddler

Thank you for considering contributing to Hoddler! This document outlines the process for contributing to the project.

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md).

## How Can I Contribute?

### Reporting Bugs

- Check if the bug has already been reported in the [Issues](https://github.com/yourusername/hoddler/issues)
- If not, create a new issue with a clear title and description
- Include steps to reproduce, expected behavior, and actual behavior
- Add screenshots if applicable
- Specify your environment (OS, browser, Ruby version, etc.)

### Suggesting Features

- Check if the feature has already been suggested in the [Issues](https://github.com/yourusername/hoddler/issues)
- If not, create a new issue with a clear title and description
- Explain why this feature would be useful to most users
- Provide examples of how the feature would work

### Pull Requests

1. Fork the repository
2. Create a new branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run the tests to ensure they pass
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Process

### Setting Up Your Development Environment

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/hoddler.git
   cd hoddler
   ```

2. Install dependencies
   ```bash
   bundle install
   yarn install
   ```

3. Configure MongoDB
   - Update `config/mongoid.yml` with your MongoDB connection settings

4. Set up environment variables
   - Create a `.env` file in the root directory based on `.env.example`

5. Initialize the database
   ```bash
   rails db:seed
   ```

6. Start the server
   ```bash
   bin/dev
   ```

### Code Style

- Follow the [Ruby Style Guide](https://github.com/rubocop/ruby-style-guide)
- Use 2 spaces for indentation
- Keep lines under 100 characters
- Write descriptive commit messages

### Testing

- Write tests for all new features and bug fixes
- Ensure all tests pass before submitting a pull request
- Run tests with `rails test`

## Project Structure

- `app/models` - MongoDB document models
- `app/services` - Service objects for business logic
- `app/controllers` - Controllers for handling requests
- `app/views` - Views for rendering HTML
- `app/javascript` - JavaScript components and modules

## Service Architecture

Hoddler uses a service-oriented design pattern:

- **API Services**: Handle communication with Binance API
  - `ImportTrades`: Fetches and stores trade history
  - `ImportKlines`: Retrieves candlestick data
  
- **Processing Services**:
  - `GenerateMarkers`: Creates visual markers from trade data
  - `UpdateTicker`: Calculates and updates ticker statistics

## Documentation

- Update the README.md with any changes to installation or usage instructions
- Document new features and APIs
- Add comments to complex code sections

## Questions?

Feel free to reach out if you have any questions about contributing to Hoddler.
