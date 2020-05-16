Rails.application.routes.draw do
  root 'dashboard#show'

  get 'dashboard/show'

  get 'username', to: 'users#username'
  get 'user', to: 'users#show'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :customers
  resources :articles
  resources :companies

  resources :forms do 
    collection do
      get '/:status', to: 'forms#index'
    end
  end

  resources :projects do
    resources :forms do
      collection do
        get '/:status', to: 'forms#index'
      end
      resources :entries
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
