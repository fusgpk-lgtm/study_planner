Rails.application.routes.draw do
  get 'study_times/create'
  get 'study_times/index'
  get 'units/new'
  get 'units/create'
  root to: 'students#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  get '/teachers/sign_up', to: 'users/registrations#new', defaults: { role: 'teacher' }
  resources :students

  resources :textbooks, only: [] do
    resources :units, only: [:new, :create]
  end
end
