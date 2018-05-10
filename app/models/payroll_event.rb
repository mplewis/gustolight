class PayrollEvent < ApplicationRecord
  KAFKA_TOPIC = 'zenpayroll.company'.freeze

  consume_from_kafka KAFKA_TOPIC

  PROCESSING_STATUSES = ['Processed', 'Processed and Unfunded'].freeze

  def self.consume(topic, message)
    payroll_processing_last_modified = message['payroll_processing_last_modified'] && DateTime.parse(message['payroll_processing_last_modified'])
    payroll_processing_status = message['payroll_processing_status']
    company_id = message['id']

    return unless PROCESSING_STATUSES.include?(payroll_processing_status)

    find_or_create_by!(company_id_hash: hash_id(company_id), timestamp: payroll_processing_last_modified)
  end

  def self.hash_id(id)
    Digest::SHA1.hexdigest(id)
  end

  def num_payrolls_processed

  end
end
