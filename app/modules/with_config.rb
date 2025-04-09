# frozen_string_literal: true

module WithConfig
  def config
    "Workflows::#{bot.config_slug.camelize}::Config".constantize
  end

  def keyboards
    "Workflows::#{bot.config_slug.camelize}::Keyboards".constantize
  end

  def workflow_command?
    allowed_actions.keys.include?(text)
  end

  def allowed_actions
    config::STATE_ACTIONS[user.state]
  end

  def action
    allowed_actions[text]
  end

  def process_workflow
    return if action.nil?

    "Workflows::#{bot.config_slug.camelize}::Process::#{action.camelize}".constantize.call(user)
  end
end
