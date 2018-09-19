require 'yaml'
require 'shoryuken'

if ENV['AWS_SECRET_ACCESS_KEY']

  # load SQS credentials
  YAML.safe_load File.read(File.join(File.expand_path('../../', __FILE__), 'shoryuken.yml'))

  sqs = Aws::SQS::Client.new(
      endpoint: ENV["SQS_SERVER_MOCK_URL"],
      verify_checksums: false
  )

  default_queue_url = sqs.create_queue(queue_name: ENV['QUEUE_NAME']).queue_url

  dead_letter_queue_url = sqs.create_queue(queue_name: ENV['QUEUE_NAME_FAILURES']).queue_url

  dead_letter_queue_arn = sqs.get_queue_attributes(
    queue_url: dead_letter_queue_url,
    attribute_names: %w[QueueArn]
  ).attributes['QueueArn']

  attributes = {}
  attributes['RedrivePolicy'] = %({"maxReceiveCount":2, "deadLetterTargetArn":"#{dead_letter_queue_arn}"})

  sqs.set_queue_attributes queue_url: default_queue_url, attributes: attributes
end