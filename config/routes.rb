Rails.application.routes.draw do
  get 'maps/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: "homes#top"
  get "home/about" => "homes#about"

  get "search" => "searches#search", as: :search

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update] do
    get "followings" => "users#followings"
    get "followers" => "users#followers"
    resource :relationships, only: [:create, :destroy]
    resource :direct_messages, only: [:index, :show, :create, :destroy]
  end

  resources :notifications, only: [:update]
  resource :map, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
