# frozen_string_literal: true

class ReplyMarkup
  include WithConfig

  attr_reader :bot

  def initialize(bot)
    @bot = bot
  end

  def blank
    { resize_keyboard: true }.to_json
  end

  def remove
    { remove_keyboard: true }.to_json
  end

  def share_number
    text = 'Share'

    { keyboard: [[text:, request_contact: true]], resize_keyboard: true }.to_json
  end

  def main
    config.main_keyboard.to_json
  end

  def link(text:, url:)
    { remove_keyboard: true, inline_keyboard: [[{ text:, url: }]] }
  end
end
