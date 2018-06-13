Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'devise_custom/registrations' }

  mount PolicyManager::Engine => "/policies", as: 'policies'

  root 'home#index'

  get '/session/areas/:slug', to: 'session/areas#create', as: 'area'

  resources :areas, only: :show do
    member do
      get '/categories', to: 'categories#index'
      get '/categories/:category_id', to: 'categories#show'
    end

    resources :organizations, only: [:show, :new, :create, :edit, :update]
  end

  namespace :profile do
    resources :own_organizations, only: [:index]    
    resources :favorite_organizations, only: [:index]
    resources :claimed_organizations, only: [:index]
  end

  resources :organizations, only: [] do
    resources :claims, only: [:create, :show, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  get '/categories/:id/organizations', to: 'organizations#index', as: 'category_organizations'
end
