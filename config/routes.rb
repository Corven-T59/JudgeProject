Rails.application.routes.draw do
  
  
  authenticate :user do
    resources :contests, except: [:index, :show] do
      post 'subscribe', on: :member
      post 'unsubscribe', on: :member
    end
		resources :solutions, only: [:create, :new]
		resources :problems, except: [:index, :show]
    
  end
  resources :contests, only: [:index, :show]
  resources :solutions, only: [:index, :show]
  resources :problems, only: [:index, :show]
  resources :executions, only: [:show, :index]

  devise_for :users
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
