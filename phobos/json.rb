# frozen_string_literal: true

%w[
  json
  phobos
].each(&method(:require))

class JsonHandler
  include Phobos::Handler

  def consume(payload, metadata)
    params = JSON.parse(payload)
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
