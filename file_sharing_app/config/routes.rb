Rails.application.routes.draw do
  get 'user_files/index'
  get 'user_files/create'
  get 'user_files/destroy'
  get 'user_files/download'
  get 'user_files/toggle_public'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'dashboard#index'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'dashboard#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users, only: [:edit, :update]
  resources :user_files, only: [:index, :create, :destroy] do
    member do
      get :download
      post :toggle_public
    end
    collection do
      get :upload
    end
  end

  get 'shared/:public_url', to: 'user_files#show_public', as: :public_file
  get 'shared/:public_url/download', to: 'user_files#download_public', as: :download_public_file
end
