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
    # post 'photometer_data_uploads', to: 'photometer_data_uploads#create'
    resources :photometer_data_uploads, only: :create
  end

  root 'vessels#index'
end
