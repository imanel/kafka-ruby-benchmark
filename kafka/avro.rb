require 'avro_turf'
require 'kafka'

avro = AvroTurf.new(schemas_path: File.join(__dir__, '..', 'avro_schema'))
kafka = Kafka.new(seed_brokers: ["127.0.0.1:9092"])
consumer = kafka.consumer(group_id: 'kafka_avro')
consumer.subscribe('kafka_bench_avro')

consumer.each_message do |message|
  params = avro.decode(message.value, schema_name: 'address')
  @count ||= 0
  @starting_time = Time.now if @count == 0
  @count += 1

  if @count >= 100_000
    time_taken = Time.now - @starting_time
    puts "Time taken: #{time_taken}"
    @count = 0
  end
end
