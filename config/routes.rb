Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get '/session/areas/:slug', to: 'session/areas#create', as: 'area'

  resources :areas, only: :show do
    member do
      get '/categories', to: 'categories#index'
      get '/categories/:category_id', to: 'categories#show'
    end

    resources :organizations, only: [:show, :new, :create, :edit, :update]
  end

  get '/categories/:id/organizations', to: 'organizations#index', as: 'category_organizations'
end
