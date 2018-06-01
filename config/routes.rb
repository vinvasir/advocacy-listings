Rails.application.routes.draw do
  root 'home#index'

  get '/session/areas/:slug', to: 'session/areas#create', as: 'area'

  resources :areas, only: :show do
    resources :categories, only: [:index, :show] do
      resources :organizations, only: [:index, :show]
    end

    resources :organizations, only: [:new, :create, :edit, :update]
  end
end
