# frozen_string_literal: true

Racecar.configure do |config|
  config.log_level = 'warn'
  config.brokers = [ENV['KAFKA_HOST'] || '127.0.0.1:9092']
  config.client_id = "racecar_#{Time.now.to_i}"
end
