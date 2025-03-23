# frozen_string_literal: true

module Search
  class Find < ApplicationService
    def call(index:, query:)
      ELASTICSEARCH_CLIENT.search(index:, body: {
                                    query: {
                                      match: { name: { query: Translit.convert(query, :english), fuzziness: 'AUTO' } }
                                    },
                                    size: 3
                                  })
    end
  end
end
