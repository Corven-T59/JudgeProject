Rails.application.routes.draw do

  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :users, only: [:index, :show]


  unauthenticated :user do
    #devise_scope :user do
      root "welcome#landing"
    #end
  end
  authenticate :user do
    resources :contests, except: [:index, :show] do
      post 'subscribe', on: :member
      post 'unsubscribe', on: :member
      get 'submit', on: :member
      resources :solutions, only: [:create, :new]
    end
    resources :problems, except: [:index, :show]
    resources :users, only: [:edit, :update]
    root "welcome#index"
  end

  resources :contests, only: [:index, :show] do
    get 'scoreboard', on: :member
    get 'problems', on: :member
    get 'handles', on: :member
    resources :solutions, only: [:index, :show]
  end
  get "/search", to: "welcome#search"
  resources :solutions, only: [:index, :show]
  resources :problems, only: [:index, :show]
  resources :executions, only: [:show, :index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
