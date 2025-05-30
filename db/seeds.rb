# frozen_string_literal: true

return unless Rails.env.development?

admin = AdminUser.find_by(email: 'admin@example.com')
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if admin.blank?

InitializeBot.call
