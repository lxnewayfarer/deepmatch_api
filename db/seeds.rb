# frozen_string_literal: true

return unless Rails.env.development?

admin = AdminUser.find_by(email: 'admin@inflowbot.ru')
AdminUser.create!(email: 'admin@inflowbot.ru', password: 'F1rewa11', password_confirmation: 'F1rewa11') if admin.blank?

InitializeTenant.call
