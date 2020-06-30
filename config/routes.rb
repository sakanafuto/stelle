Rails.application.routes.draw do
  get 'posts/show'
  get 'posts/index'
  get 'posts/new'
  get 'users/show'
  get 'users/index'
  get 'users/edit'
  devise_for :users
end
