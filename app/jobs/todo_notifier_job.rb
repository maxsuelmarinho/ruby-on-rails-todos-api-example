class TodoNotifierJob < ApplicationJob
  queue_as :default

  rescue_from ActiveJob::DeserializationError do |ex|
    Shoryuken.logger.error ex
    Shoryuken.logger.error ex.backtrace.join("\n")
  end

  def perform(todo)
      p "============================="
      p "TodoNotifierJob perform..."
      p "============================="
      raise "error"
  end
end
