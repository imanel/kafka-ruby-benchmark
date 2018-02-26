# frozen_string_literal: true

# Consumer used to consume benchmark messages
class BenchConsumer < Karafka::BaseConsumer
  def consume
    params_batch.to_a.each do |params_raw|
      JSON.parse(params_raw[:value])

      @@count ||= 0
      @@starting_time = Time.now if @@count.zero?
      @@count += 1

      next unless @@count >= 100_000

      time_taken = Time.now - @@starting_time
      puts "Time taken: #{time_taken}"
      @@count = 0
      mark_as_consumed params_raw
    end
  end
end
