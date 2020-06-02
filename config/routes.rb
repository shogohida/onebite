Rails.application.routes.draw do
  get 'enrollments/index'
  get 'enrollments/show'
  get 'enrollments/new'
  get 'courses/index'
  get 'users/show'
  devise_for :users
  root to: 'pages#home'

  resources :courses, only: [:index, :show] do
    resources :enrollments, only: [:new, :create]
  end
  # resources :courses, only: [:index, :show] do
  #   resources :chapters, only: [:show, :update]
  # end
  resources :chapters, only: [:show, :update]
  # [:edit, ]
  resources :enrollments, only: [:index, :show, :update]
  resources :users, only: :show

  # routes for 'follow / unfollow a user' feature
  post 'users/:id/follow', to: 'users#follow', as: :follow_user
  post 'users/:id/unfollow', to: 'users#unfollow', as: :unfollow_user

  # routes for 'search for a user' feature
  get '/users', to: 'users#index', as: :users

  # route for showing user stats page
  get 'users/:id/mystats', to: 'users#mystats', as: :user_mystats

  # left as a memo for Merit gem
  # devise_for :users, controllers: { registrations: 'users/registrations' }
end
