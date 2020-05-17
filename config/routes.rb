Rails.application.routes.draw do
  root 'dashboard#show'

  get 'registration', to: 'users#new'

  get 'username', to: 'users#username'
  get 'user', to: 'users#show'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :customers
  resources :articles
  resources :companies
  resources :npks
  resources :employees

  resources :forms do 
    collection do
      get '/status/:status', to: 'forms#index'
    end
  end

  resources :projects do
    resources :forms do
      get 'pdf', to: 'forms#generate'
      collection do
        get '/status/:status', to: 'forms#index'
        post '/status/:status', to: 'forms#create'
      end
      resources :entries do
        resources :articles_entries
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
