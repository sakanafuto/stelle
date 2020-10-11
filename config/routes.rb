Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: %i[index show edit update destroy]
  get 'users', to: 'posts#index'

  resources :posts
  resources :likes, only: %i[create destroy]
  resources :relationships, only: %i[create destroy]
end
