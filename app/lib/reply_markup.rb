# frozen_string_literal: true

class ReplyMarkup
  attr_reader :bot

  def initialize(bot = nil)
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

  def fetch(name)
    send(name).to_json
  end

  def link(text:, url:)
    { remove_keyboard: true, inline_keyboard: [[{ text:, url: }]] }
  end

  def main
    {
      keyboard: StatesConfig::STATE_ACTIONS['main'].keys.map { |key| [text: key] },
      resize_keyboard: true
    }
  end

  def new_task
    {
      keyboard: StatesConfig::STATE_ACTIONS['new_task'].keys.map { |key| [text: key] },
      resize_keyboard: true
    }
  end
end
