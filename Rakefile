require 'avro_turf'
require 'json'
require 'kafka'

namespace :bench do
  desc 'Fill kafka with data for benchmark'
  task :fill_kafka do
    puts 'Inserting 1M records in batches of 500, it might take some time'

    message = { 'street' => '1st st.', 'city' => 'Citytown' }

    avro = AvroTurf.new(schemas_path: File.join(__dir__, 'avro_schema'))
    message_avro = avro.encode(message, schema_name: 'address')
    message_json = message.to_json

    kafka = Kafka.new seed_brokers: ['127.0.0.1:9092'], client_id: 'my_producer'
    producer = kafka.producer
    2_000.times do # Save 1M in batch of 500 (limit for Kafka)
      500.times do
        producer.produce(message_avro, topic: 'kafka_bench_avro')
        producer.produce(message_json, topic: 'kafka_bench_json')
      end
      producer.deliver_messages
    end
  end
end
