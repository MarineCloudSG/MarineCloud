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

  resources :vessels do
    resources :photometer_data_uploads, only: :create
    resources :manual_measurements_data_uploads, only: :create
    resources :vessel_comments, only: :create
  end

  get :overview, to: 'vessels#overview'

  root 'vessels#index'
end
