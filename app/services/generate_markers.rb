class GenerateMarkers < ApplicationService
  include TradeCalculations
  
  def initialize(ticker)
    super()
    @ticker = ticker
  end

  def call
    Rails.logger.info("Generating markers for ticker #{@ticker.symbol}")
    
    begin
      if @ticker.trades.empty?
        return add_error("No trades found for ticker #{@ticker.symbol}")
      end
      
      trading_days = @ticker.trades.map { |t| t[:timestamp].to_date }.uniq
      Rails.logger.debug("Found #{trading_days.size} trading days for #{@ticker.symbol}")
      
      markers = []
      
      trading_days.each do |day|
        day_trades = @ticker.trades.filter { |t| t[:timestamp].to_date == day }
        
        begin
          reduced = reduce_trades(day_trades)
          
          markers << {
            price: reduced[:price],
            quantity: reduced[:quantity],
            buy?: reduced[:quantity].positive?,
            timestamp: day,
            ticker_id: @ticker.id
          }
        rescue StandardError => e
          Rails.logger.error("Error processing trades for day #{day}: #{e.message}")
          # Continue with other days even if one fails
        end
      end
      
      if markers.empty?
        return add_error("No valid markers could be generated")
      end
      
      Rails.logger.debug("Creating #{markers.size} markers for #{@ticker.symbol}")
      created_markers = Marker.create(markers)
      
      if created_markers.all?(&:persisted?)
        Rails.logger.info("Successfully created #{created_markers.size} markers for #{@ticker.symbol}")
        true
      else
        failed = created_markers.reject(&:persisted?)
        add_error("Failed to create #{failed.size} markers: #{failed.map { |m| m.errors.full_messages }.flatten.join(', ')}")
      end
    rescue StandardError => e
      Rails.logger.error("Error in GenerateMarkers: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      add_error("Unexpected error: #{e.message}")
    end
  end
end
