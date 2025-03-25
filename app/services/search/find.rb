# frozen_string_literal: true

module Search
  class Find < ApplicationService
    # Returns array of items like
    # [{"_index" => "test", "_id" => "15", "_score" => 1.5780822, "_source" => {"name" => "yeti rambler 20oz tumbler"}}]
    def call(index:, query:)
      response = ELASTICSEARCH_CLIENT.search(index:, body: {
                                               query: {
                                                 match: { name: { query: Translit.convert(query, :english).downcase, fuzziness: 'AUTO' } }
                                               },
                                               size: 3
                                             })

      response.body.dig('hits', 'hits')
    end
  end
end
