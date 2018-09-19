class TodoNotifierDlqJob < ApplicationJob
  queue_as :dlq

  rescue_from ActiveJob::DeserializationError do |ex|
    Shoryuken.logger.error ex
    Shoryuken.logger.error ex.backtrace.join("\n")
  end

  def perform(todo)
      p "============================="
      p "TodoNotifierDlqJob perform..."
      p "============================="
  end
end
