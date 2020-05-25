Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources: courses, only: [:index] do
    resources: enrollments, only: [:new, :create]
  end
  resources: enrollments, only: [:index, :show]
  resources: users, only: :show
end
