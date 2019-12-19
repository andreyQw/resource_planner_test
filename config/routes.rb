# frozen_string_literal: true

Rails.application.routes.draw do
  resources :employees
  resources :projects
  resources :events
end
