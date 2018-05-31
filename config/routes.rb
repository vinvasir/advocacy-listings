Rails.application.routes.draw do
  root 'home#index'

  get '/session/areas/:id', to: 'session/areas#create', as: 'area'

  get '/areas/:id', to: 'categories#index', as: 'categories' do

    get '/listings/:id', to: 'listings#show'
  end
end
