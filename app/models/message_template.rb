# frozen_string_literal: true

class MessageTemplate < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :bot

  def full_image_url
    "#{ENV['BACKEND_URL']}#{image_url}"
  end
end
