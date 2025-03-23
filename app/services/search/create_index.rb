# frozen_string_literal: true

module Search
  class CreateIndex < ApplicationService
    def call(index:)
      return if ELASTICSEARCH_CLIENT.indices.exists(index:)

      ELASTICSEARCH_CLIENT.indices.create(index:)
    end
  end
end
