class TodoNotifierWorker
  include Shoryuken::Worker

  shoryuken_options queue: ENV['QUEUE_NAME'], auto_delete: true, body_parser: JSON

  def perform(_sqs_msg, body)
      p "============================="
      p "TodoNotifierWorker perform..."
      p "============================="
      p "Force the message to fail to be delivered to the dlq"
      raise "error"
  end
end
