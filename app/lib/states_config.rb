# frozen_string_literal: true

class StatesConfig
  STATE_ACTIONS = {
    'initial' => {
      '/start' => 'start'
    },
    'main' => {
      'Новая задача' => 'new_task',
      'Список задач' => 'tasks_list',
      'Поддержка' => 'support'
    },
    'new_task' => {
      'Назад' => 'to_main'
    }
  }.freeze
end
