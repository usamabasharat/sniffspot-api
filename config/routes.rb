# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: 'localhost:3000' if Rails.env.test?
  default_url_options host: 'https://illusive-app.herokuapp.com'

  namespace :api do
    resources :spots, only: %i[index create update] do
      resources :reviews, shallow: true, only: %i[create update]
    end
  end
end
