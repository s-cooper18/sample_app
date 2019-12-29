Rails.application.routes.draw do
  
  get 'users/new'
  root 'static_pages#home'

  # creates fdfjhskj_path and adjksldj _url
  # can use as: __ at end to change what the path or url refers to
  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/signup', to: 'users#new'

  post '/signup', to: 'users#create'

  resources :users

end
