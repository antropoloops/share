# frozen_string_literal: true

Rails.application.routes.draw do
  # Admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :admin do
    authenticate :admin_user do
      mount Sidekiq::Web => '/jobs'
    end
  end

  # Import
  post '/import/audioset', to: 'imports#audioset'
  post '/import/track', to: 'imports#track'
  post '/import/clip', to: 'imports#clip'
  post '/import/media', to: 'imports#media'

  # Public
  resource :status, only: :show
  resources :audiosets
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_error', via: :all
  root to: redirect('/admin')
end
