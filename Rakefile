require 'avro_turf'
require 'benchmark'
require 'json'
require 'kafka'
require 'multi_json'

namespace :bench do
  desc 'Fill kafka with data for benchmark'
  task :fill_kafka do
    puts 'Inserting 1M records in batches of 1000, it might take some time'

    message = { 'street' => '1st st.', 'city' => 'Citytown' }
    message_json = message.to_json

    kafka = Kafka.new seed_brokers: ['127.0.0.1:9092'], client_id: 'my_producer'
    producer = kafka.producer
    1_000.times do # Save 1M in batch of 1000 (limit for Kafka)
      1_00.times do
        producer.produce(message_json, topic: 'kafka_bench_json')
      end
      producer.deliver_messages
    end
  end

  desc 'Benchmark JSON vs AVRO'
  task :avro do
    N = 100_000

    Benchmark.bm(30) do |x|
      sizes = [1, 10, 100, 1_000, 10_000]
      avro = AvroTurf.new(schemas_path: File.join(__dir__, 'avro_schema'))

      sizes.each do |size|
        message = {
          'street' => '1st st.' * size,
          'city' => 'Citytown' * size
        }
        message_json = message.to_json
        message_avro = avro.encode(message, schema_name: 'address')

        x.report("JSON size #{size}:") do
          N.times { JSON.parse(message_json) }
        end
        x.report("MultiJson size #{size}:") do
          N.times { MultiJson.load(message_json) }
        end
        x.report("AVRO explicit schema size #{size}:") do
          N.times { avro.decode(message_avro, schema_name: 'address') }
        end
        x.report("AVRO implicit schema size #{size}:") do
          N.times { avro.decode(message_avro) }
        end
      end
    end
  end
end
