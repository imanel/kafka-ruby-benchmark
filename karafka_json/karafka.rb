# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']
Bundler.require(:default, ENV['KARAFKA_ENV'])
Karafka::Loader.load(Karafka::App.root)
Karafka.logger.level = Logger::WARN

require 'json'

class JsonGemParser
  def self.parse(message)
    ::JSON.parse(message)
  rescue ::JSON::JSONError => e
    raise ::Karafka::Errors::ParserError, e
  end
end

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = %w[kafka://127.0.0.1:9092]
    config.client_id = 'karafka_json'
    config.backend = :inline
    config.batch_fetching = true
    config.parser = JsonGemParser
  end

  consumer_groups.draw do
    topic :kafka_bench_json do
      controller ApplicationController
    end
  end
end

KarafkaApp.boot!
