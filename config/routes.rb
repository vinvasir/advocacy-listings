Rails.application.routes.draw do
  root 'home#index'

  get '/session/areas/:id', to: 'session/areas#create'

  get '/areas/:id', to: 'categories#index', as: 'area' do

    get '/listings/:id', to: 'listings#show'
  end
end
