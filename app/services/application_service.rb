class ApplicationService
  attr_reader :errors

  def self.call(...)
    new(...).call
  end
  
  def initialize(*)
    @errors = []
  end
  
  protected
  
  def add_error(message)
    @errors << message
    false
  end
  
  def success?
    @errors.empty?
  end
end
