# frozen_string_literal: true

REDIS = ConnectionPool::Wrapper.new { Redis.new(url: ENV['REDIS_URL']) }
