Rails.application.routes.draw do
  root to: 'students#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 講師用の登録ページ
  get '/teachers/sign_up', to: 'users/registrations#new', defaults: { role: 'teacher' }

  # 生徒
  resources :students do
    resources :study_times, only: [:index, :create] # 生徒ごとの学習時間
  end

  # 教材と単元
  resources :textbooks, only: [] do
    resources :units, only: [:new, :create]
  end
end