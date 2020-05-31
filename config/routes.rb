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
  resources :enrollments, only: [:index, :show]
  resources :users, only: :show

  post 'users/:id/follow', to: 'users#follow', as: :follow_user
  post 'users/:id/unfollow', to: 'users#unfollow', as: :unfollow_user
end
