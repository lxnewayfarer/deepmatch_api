# frozen_string_literal: true

module WithConfig
  def config
    "Workflows::#{bot.config_slug.classify}::Config".constantize
  end

  def workflow_command?
    config.actions.keys.include?(text)
  end

  def process_workflow
    "Workflows::#{bot.config_slug.classify}::Process::#{config.actions[text].classify}".constantize.call(user)
  end
end
