# frozen_string_literal: true

module WithConfig
  def config
    "Workflows::#{bot.config_slug.camelize}::Config".constantize
  end

  def workflow_command?
    config.actions.keys.include?(text)
  end

  def process_workflow
    "Workflows::#{bot.config_slug.camelize}::Process::#{config.actions[text].camelize}".constantize.call(user)
  end
end
