# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :admin do
    authenticate :admin_user do
      mount Sidekiq::Web => '/jobs'
    end
  end

  devise_for :users
  resources :spaces do
    resources :assets
  end

  resource :status, only: :show
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_error', via: :all
  root 'spaces#index'
end
