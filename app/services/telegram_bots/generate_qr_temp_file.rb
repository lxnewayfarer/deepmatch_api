# frozen_string_literal: true

module TelegramBots
  class GenerateQrTempFile < ApplicationService
    def call(data)
      file = generate_qr_file(data)

      temp_file = Tempfile.new([SecureRandom.uuid, '.png'])
      temp_file.binmode
      temp_file.write(file)
      file.save(temp_file.path, :fast_rgba)
      temp_file.rewind

      temp_file
    end

    private

    def generate_qr_file(data)
      RQRCode::QRCode.new(data)
                     .as_png(
                       bit_depth: 1,
                       border_modules: 4,
                       color_mode: ChunkyPNG::COLOR_GRAYSCALE,
                       color: 'black',
                       fill: 'white',
                       module_px_size: 6,
                       resize_exactly_to: false,
                       resize_gte_to: false,
                       size: 720
                     )
    end
  end
end
