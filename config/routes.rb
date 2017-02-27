Rails.application.routes.draw do
  resources :executions, only: [:show, :index]
  resources :solutions
  resources :problems
  devise_for :users
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
