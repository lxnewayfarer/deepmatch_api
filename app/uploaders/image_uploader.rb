# frozen_string_literal: true

require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :derivatives

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    { small: magick.resize_to_limit!(200, 200) }
  end
end
