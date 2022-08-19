Rails.application.routes.draw do
  get 'password_resets/new'
  post 'password_resets/store'

  get 'password_resets/change_password'
  post 'password_resets/update'
  #get 'password_resets/edit'
  # post 'password_resets/update'
  get 'password_resets/send_email_success'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'staffs/new'
  get '/home', to: 'static_pages#home', as:'helf'
  get '/help', to: 'static_pages#help'
  resources :microposts
  resources :users
  resources :account_activations, only: [:edit]
  # resources :password_resets, only: [:new, :create, :edit, :update]
  # root 'application#hello'
  get '/signup', to: 'users#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
