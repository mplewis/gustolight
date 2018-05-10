# require 'kafka/datadog'
# require 'metrics/errors/notifications_manager'

# Kafka::Datadog.namespace = 'lightwell.kafka'
# Kafka::Datadog.host = ENV['DATADOG_AGENT_HOST']
# Kafka::Datadog.port = ENV['DATADOG_AGENT_PORT']
require_dependency 'payroll_event'

KafkaRails.configure do |config|
  # config.enabled      = Config.kafka.enabled
  config.topic_prefix = 'lightwell'
  config.client_id    = 'lightwell'
  config.consumer_group = 'lightwell'

  config.seed_brokers         = ENV['KAFKA_URL']
  config.ssl_ca_cert          = ENV['KAFKA_TRUSTED_CERT']
  config.ssl_client_cert      = ENV['KAFKA_CLIENT_CERT']
  config.ssl_client_cert_key  = ENV['KAFKA_CLIENT_CERT_KEY']

  config.consumer_min_bytes =       ENV['KAFKA_MIN_BYTES'] || 1024 #5KB default
  config.consumer_max_wait_time =   ENV['KAFKA_MAX_WAIT_TIME'] || 5 #seconds
  config.consumer_session_timeout = ENV['CONSUMER_SESSION_TIMEOUT'] || 90 #seconds

  config.logger = Logger.new(STDOUT).tap{|l| l.level = Logger::INFO}

  # config.on_error do |e, file, line|
    # Metrics::Errors::NotificationsManager.notify(e, file, line)
  # end
end

# KafkaRails.register_consumer(ExampleConsumer)
