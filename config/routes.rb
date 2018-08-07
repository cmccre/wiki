Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
  root 'articles#index'
  post '/', to: 'articles#index'
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'
  put '/users/inactivate', to: 'users#toggle_is_active'
  put '/users/activate', to: 'users#toggle_is_active'

end
