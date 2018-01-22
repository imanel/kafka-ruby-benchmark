require 'avro_turf'
require 'phobos'

class AvroHandler
  include Phobos::Handler

  AVRO = AvroTurf.new(schemas_path: File.join(__dir__, '..', 'avro_schema'))

  def consume(payload, metadata)
    params = AVRO.decode(payload, schema_name: 'address')
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
