# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks, except: %i[new edit], param: :slug
  resources :users, only: %i[index create]
  root "home#index"
  get "*path", to: "home#index", via: :all
end
