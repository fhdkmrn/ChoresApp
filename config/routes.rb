# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homepage#index'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  post 'logout' => 'sessions#destroy'
  get 'signup' => 'user#new'
  post 'user' => 'user#create'
  get 'user' => 'user#show'
  get 'leaderboard' => 'leaderboard#index'
  get 'weekly' => 'weekly#index'
  get 'weekly/events' => 'weekly#events'
  get 'user/:id' => 'user#others'
  post 'user/:id/approve' => 'user#approve'
  get 'user/:id/trade' => 'user#trade'
  post 'user/:id/acceptTrade' => 'user#acceptTrade'
  post 'user/decline_trade' => 'user#declineTrade'
  resources :user
end
