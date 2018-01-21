namespace :bench do
  desc 'Fill kafka with data for benchmark'
  task :fill_kafka do
    puts 'Inserting 1M records in batches of 1k, it might take some time'
    require 'json'
    require 'kafka'
    message = { hello: 'world!' }.to_json

    kafka = Kafka.new seed_brokers: ['127.0.0.1:9092'], client_id: 'my_producer'
    producer = kafka.producer
    1_000.times do # Save 1M in batch of 1k (limit for Kafka)
      1_000.times do
        producer.produce(message, topic: 'kafka_bench_json')
      end
      producer.deliver_messages
    end
  end
end
