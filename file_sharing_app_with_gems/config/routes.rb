Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/update'
  get 'pages/home'
  get 'pages/dashboard'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'pages#dashboard'
  resource :profile, only: [:show, :update]
  resources :files, only: [:index, :new, :create, :destroy] do
    member do
      get :download
      post :toggle_public
    end
  end

  get 'shared/:id', to: 'files#show_public', as: :public_file
  get 'shared/:id/download', to: 'files#download', as: :public_download_file

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
