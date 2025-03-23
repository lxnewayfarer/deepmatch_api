# frozen_string_literal: true

# config/initializers/elasticsearch.rb

ELASTICSEARCH_CLIENT = ConnectionPool::Wrapper.new do
  Elasticsearch::Client.new(
    hosts: [{
      host: ENV['ELASTICSEARCH_HOST'],
      port: 9200,
      log: true
    }]
  )
end
