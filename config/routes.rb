Rails.application.routes.draw do
  get 'staffs/new'
  get '/home', to: 'static_pages#home', as:'helf'
  get '/help', to: 'static_pages#help'
  resources :microposts
  resources :users
  root 'application#hello'
  get '/signup', to: 'staffs#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
