require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  # FIXME: Secure
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :vessels

  root 'vessels#index'
end
