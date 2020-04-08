Rails.application.routes.draw do
  get 'companies/customers'
  get 'companies/projects'
  get 'projects/show'
  get 'projects/create'
  get 'projects/update'
  get 'projects/destroy'
  root 'dashboard#show'

  get 'dashboard/show'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  resources :customers
  resources :articles
  resources :companies
  resources :offers
  resources :projects do
    resources :offers
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
