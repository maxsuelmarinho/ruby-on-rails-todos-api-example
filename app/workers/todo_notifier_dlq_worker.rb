class TodoNotifierDlqWorker
  include Shoryuken::Worker

  shoryuken_options queue: ENV['QUEUE_NAME_FAILURES'], auto_delete: true, body_parser: JSON

  def perform(_sqs_msg, body)
      p "============================="
      p "TodoNotifierDlqJob perform..."
      p "============================="
  end
end
