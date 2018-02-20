# frozen_string_literal: true

%w[
  json
  kafka
].each(&method(:require))

ENV['KAFKA_HOST'] ||= '127.0.0.1:9092'

kafka = Kafka.new(seed_brokers: [ENV['KAFKA_HOST']])
consumer = kafka.consumer(group_id: "kafka_json_batch_#{Time.now.to_i}")
consumer.subscribe('kafka_bench_json')

consumer.each_batch do |batch|
  batch.messages.each do |message|
    params = JSON.parse(message.value)
    @count ||= 0
    @starting_time = Time.now if @count == 0
    @count += 1

    if @count >= 100_000
      time_taken = Time.now - @starting_time
      puts "Time taken: #{time_taken}"
      @count = 0
    end
  end
end
