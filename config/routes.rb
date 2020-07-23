Rails.application.routes.draw do
  get 'enrollments/index'
  get 'enrollments/show'
  get 'enrollments/new'
  get 'courses/index'
  get 'users/show'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  resources :courses, only: [:index, :show] do
    resources :enrollments, only: [:new, :create]
  end

  resources :chapters, only: [:show, :update]
  resources :enrollments, only: [:index, :show, :update]
  resources :users, only: :show

  # routes for 'follow / unfollow a user' feature
  post 'users/:id/follow', to: 'users#follow', as: :follow_user
  post 'users/:id/unfollow', to: 'users#unfollow', as: :unfollow_user

  # routes for 'search for a user' feature
  get '/users', to: 'users#index', as: :users

  # route to scrape Duolingo
  get '/user/:id', to: 'users#scrape_duolingo', as: :user_scrape_duolingo

  # left as a memo for Merit gem
  # devise_for :users, controllers: { registrations: 'users/registrations' }
end
