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

  resources :organizations, only: [] do
    member do
      resources :favorites, only: [:create, :destroy]
    end
  end

  get '/categories/:id/organizations', to: 'organizations#index', as: 'category_organizations'
end
