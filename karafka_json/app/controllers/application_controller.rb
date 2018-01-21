# frozen_string_literal: true

class ApplicationController < Karafka::BaseController
  def consume
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
