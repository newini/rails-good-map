Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  match '/get_places_json', to: 'pages#get_places_json', via: 'get'

  resources :posts
end
