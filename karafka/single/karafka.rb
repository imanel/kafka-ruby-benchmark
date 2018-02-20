# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']
ENV['KAFKA_HOST'] ||= '127.0.0.1:9092'

Bundler.require(:default, ENV['KARAFKA_ENV'])
Karafka::Loader.load(Karafka::App.root)
Karafka.logger.level = Logger::WARN

require 'json'

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = ["kafka://#{ENV['KAFKA_HOST']}"]
    config.client_id = "karafka_json_single_#{Time.now.to_i}"
    config.batch_fetching = true
    config.batch_consuming = false
  end

  consumer_groups.draw do
    consumer_group :my_group do
      automatically_mark_as_consumed false

      topic :kafka_bench_json do
        consumer BenchConsumer
      end
    end
  end
end

KarafkaApp.boot!
