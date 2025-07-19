# frozen_string_literal: true

module Errors
  class DomainError
    def self.error
      name
    end

    def self.description
      'Неизвестная ошибка'
    end
  end

  class BadRequestError < DomainError; end
end
