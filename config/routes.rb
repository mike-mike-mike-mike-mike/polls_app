# frozen_string_literal: true

Rails.application.routes.draw do
  resources :polls do
    resources :poll_responses
  end
  get 'images/new'

  root to: 'polls#new'
end
