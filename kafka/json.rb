require 'json'
require 'kafka'

kafka = Kafka.new(seed_brokers: ["127.0.0.1:9092"])
consumer = kafka.consumer(group_id: 'kafka_json')
consumer.subscribe('kafka_bench_json')

consumer.each_message do |message|
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
