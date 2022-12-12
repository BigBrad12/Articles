Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'
  get 'about', to: 'pages#about'
  resources :articles
  # root "articles#index"
  get 'signup', to: 'users#new'
  post 'login', to: 'sessions#new'
  delete 'logout', to: 'session#delete'
  resources :users, except: [:new]
end
