Rails.application.routes.draw do
  get 'units/new'
  get 'units/create'
  root to: 'students#index'
  devise_for :users
  resources :students

  resources :textbooks, only: [] do
    resources :units, only: [:new, :create]
  end
end
