require 'shoryuken'
require './config/initializers/shoryuken_dlq_active_job'

module Shoryuken
  class CustomWorkerRegistry < DefaultWorkerRegistry
    # Set explicit worker class for messages from the Dead Letter Queue
    def fetch_worker(queue, message)

      shoryuken_class = message.message_attributes['shoryuken_class'][:string_value]
      if (queue.include? 'dlq')

        if (shoryuken_class.end_with? 'Worker')
          message.message_attributes['shoryuken_class'][:string_value] = shoryuken_class.gsub(/Worker/, 'DlqWorker')
        end
      end

      super
    end
  end
end

Shoryuken.worker_registry = Shoryuken::CustomWorkerRegistry.new
