Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  get 'users/edit'
  devise_for :users
end
