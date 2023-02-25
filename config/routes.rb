# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :spots, only: %i[index create update] do
      resources :reviews, shallow: true, only: %i[create update]
    end
  end
end
