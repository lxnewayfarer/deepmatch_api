# frozen_string_literal: true

class MessageTemplate < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :bot

  def full_image_url
    return if image_url.blank?

    "#{ENV['BACKEND_URL']}#{image_url}"
  end
end
