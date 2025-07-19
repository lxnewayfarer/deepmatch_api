# frozen_string_literal: true

require 'dry/monads/all'

class ApplicationService
  include Dry::Monads[:result, :do]

  class << self
    def call(...)
      new.call(...)
    end
  end

  def call
    raise NotImplementedError
  end
end
