require 'json'
require 'racecar'

class JsonConsumer < Racecar::Consumer
  subscribes_to 'kafka_bench_json'

  def process(message)
    params = JSON.parse(message.value)
    @@count ||= 0
    @@starting_time = Time.now if @@count == 0
    @@count += 1

    if @@count >= 100_000
      time_taken = Time.now - @@starting_time
      puts "Time taken: #{time_taken}"
      @@count = 0
    end
  end
end
