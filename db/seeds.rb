# frozen_string_literal: true

return unless Rails.env.development?

admin = AdminUser.find_by(email: 'admin@merchbot.ru')
AdminUser.create!(email: 'admin@merchbot.ru', password: 'F1rewa11', password_confirmation: 'F1rewa11') if admin.blank?

InitializeTenant.call
