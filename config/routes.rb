Rails.application.routes.draw do
  resources :users
  #resources is 
  # get :users
  # get '/user/:id', to: 'users#show'
  # post '/user/:id', to: 'users#create' `
  # delete 'user/:id', to: 'users#destroy'
  # . bla bla bla like rails router -g user in console
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'create_fast', to: 'users#create_fast'
  get 'users/show2' ,to: 'users#show2'
end
