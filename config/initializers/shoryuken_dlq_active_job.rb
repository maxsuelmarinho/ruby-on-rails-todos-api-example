require 'shoryuken'

module ActiveJob
  module QueueAdapters
    class ShoryukenAdapter

      private

      class JobWrapper #:nodoc:
        include Shoryuken::Worker

        shoryuken_options body_parser: :json, auto_delete: true

        def perform(_sqs_msg, hash)
          p "ShoryukenAdapter.JobWrapper.perform"
          if (_sqs_msg.queue_name.include? 'dlq')
            hash['job_class'] = hash['job_class'].gsub(/Job/, 'DlqJob')
          end
          Base.execute hash
        end
      end
    end
  end
end