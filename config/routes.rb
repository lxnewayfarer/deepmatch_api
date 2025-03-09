# frozen_string_literal: true

Rails.application.routes.draw do
  authenticate :admin_user do
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  namespace :api do
    namespace :v1 do
      post 'telegram_webhooks/:bot_id', to: 'telegram_webhooks#create'
    end
  end

  resources :forms, only: %i[show create]
end
