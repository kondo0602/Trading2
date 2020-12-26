Rails.application.routes.draw do
  root 'items#index'
  get  '/help',     to: 'static_pages#help'
  get  '/about',    to: 'static_pages#about'
  get  '/signup',   to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :items do
    get '/likes', to: 'items#likes'
    resources :likes, only: %i[create destroy]
    resources :comments, only: [:create]
  end
  get    '/shitagaki', to: 'items#shitagaki'
  get    '/search', to: 'items#search'
  get    '/address_search', to: 'items#address_search'
  resources :rooms, only: %i[create update show index]
  resources :dms, only: [:create]
end
