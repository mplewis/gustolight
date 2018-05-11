class PayrollEvent < ApplicationRecord
  KAFKA_TOPIC = 'zenpayroll.company'.freeze

  consume_from_kafka KAFKA_TOPIC

  PROCESSING_STATUSES = ['Processed', 'Processed and Unfunded'].freeze
  MINUTES_GAP = 5

  def self.consume(topic, message)
    payroll_processing_last_modified = message['payroll_processing_last_modified'] && DateTime.parse(message['payroll_processing_last_modified'])
    payroll_processing_status = message['payroll_processing_status']
    company_id = message['id']

    if PROCESSING_STATUSES.include?(payroll_processing_status) && (payroll_processing_last_modified > (2*MINUTES_GAP).minutes.ago)
      find_or_create_by!(company_id_hash: hash_id(company_id), processing_timestamp: payroll_processing_last_modified)
    end
    DeviceEmitter.emit!(num_payrolls_processed)
    cleanup
  end

  def self.hash_id(id)
    Digest::SHA1.hexdigest(id.to_s)
  end

  def self.num_payrolls_processed
    where('processing_timestamp > ?', MINUTES_GAP.minutes.ago).count
  end

  def self.cleanup
    where('processing_timestamp < ?', (2*MINUTES_GAP).minutes.ago).delete_all
  end
end
