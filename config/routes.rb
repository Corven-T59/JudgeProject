Rails.application.routes.draw do
  resources :contests
  resources :executions, only: [:show, :index]
  authenticate :user do
		resources :solutions, only: [:create, :new]
		resources :problems, except: [:index, :show]
  end
  resources :solutions, only: [:index, :show]
  resources :problems, only: [:index, :show]
 
  devise_for :users
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
