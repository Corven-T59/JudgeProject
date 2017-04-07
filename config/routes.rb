Rails.application.routes.draw do
  

  authenticate :user do
    resources :contests, except: [:index, :show] do
      post 'subscribe', on: :member
      post 'unsubscribe', on: :member      
      get 'submit', on: :member
      resources :solutions, only: [:create, :new]
    end
		
		resources :problems, except: [:index, :show]
    
  end
  
  resources :contests, only: [:index, :show] do
    get 'scoreboard', on: :member
    resources :solutions, only: [:index, :show]
  end
  resources :solutions, only: [:index, :show]
  resources :problems, only: [:index, :show]
  resources :executions, only: [:show, :index]

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
