Rails.application.routes.draw do
  root 'dashboard#show'

  get 'registration', to: 'users#new'

  get 'username', to: 'users#username'
  get 'user', to: 'users#show'

  get 'logout', to: 'sessions#logout'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :customers
  resources :articles
  resources :companies
  resources :npks
  resources :employees

  resources :forms do
    put 'assignedEmployee', to: 'forms#assigned_employee'
    collection do
      get '/status/:status', to: 'forms#index'
    end
  end
  get '/user/forms/status/contracts', to: 'forms#index_user'
  get '/forms/compare/:contract_id', to: 'forms#compare'

  resources :projects do
    resources :forms do
      get 'pdf', to: 'forms#generate'
      post '/status/:status', to: 'forms#update_status'
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
