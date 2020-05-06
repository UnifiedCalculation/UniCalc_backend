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
  resources :offers
  resources :projects do
    resources :offers do
      resources :entries
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
