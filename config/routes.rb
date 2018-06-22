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

  namespace :admin do
    resources :claims, only: [:index, :edit, :update]

    namespace :datatable do
      get 'table-for/:table', to: 'page#index'

      resources :organizations, only: [:index]
    end
  end

  resources :organizations, only: [] do
    resources :claims, only: [:new, :create, :show, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  get '/categories/:id/organizations', to: 'organizations#index', as: 'category_organizations'

  resources :notifications, only: [:index] do
    collection do
      post :mark_as_read
    end

    post '/read', to: 'notifications#read_one'
  end
end
