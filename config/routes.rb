# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # authenticate :admin_user do
  #   mount Rswag::Ui::Engine => '/api-docs'
  #   mount Rswag::Api::Engine => '/api-docs'
  #   mount Sidekiq::Web => '/sidekiq'
  # end
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  namespace :api do
    namespace :v1 do
    end
  end
end
