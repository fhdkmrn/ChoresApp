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
  get 'users/:id' => 'user#others'
  post 'users/:id/approve' => 'user#approve'
  get 'users/:id/trade' => 'user#trade'
  post 'users/:id/acceptTrade' => 'user#acceptTrade'
  post 'users/decline_trade' => 'user#declineTrade'
end
