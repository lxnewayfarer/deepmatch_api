# frozen_string_literal: true

module Search
  class RefreshIndex < ApplicationService
    def call(items:, index:)
      items.each do |item|
        ELASTICSEARCH_CLIENT.index(index:, id: item[:id], body: { name: Translit.convert(item[:name], :english) })
      end

      ELASTICSEARCH_CLIENT.indices.refresh(index:)
    end
  end
end
