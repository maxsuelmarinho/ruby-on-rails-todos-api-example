if Rails.env.development?
    Shoryuken.configure_client do |config|
        config.sqs_client = Aws::SQS::Client.new(
            endpoint: ENV["SQS_SERVER_MOCK_URL"],
            verify_checksums: false
        )
    end

    Shoryuken.configure_server do |config|
        Rails.logger = Shoryuken::Logging.logger
        Rails.logger.level = Rails.application.config.log_level
        
        Shoryuken.active_job_queue_name_prefixing = true

        config.sqs_client = Aws::SQS::Client.new(
            endpoint: ENV["SQS_SERVER_MOCK_URL"],
            verify_checksums: false
        )
    end

    # Create the sqs with the env var name.
    Shoryuken::Client.sqs.create_queue(queue_name: ENV["SQS_QUEUE_NAME"])
    Shoryuken.sqs_client_receive_message_opts[ENV["SQS_QUEUE_NAME"]] = { wait_time_seconds: 20 }
else
    Shoryuken.active_job_queue_name_prefixing = true
end

