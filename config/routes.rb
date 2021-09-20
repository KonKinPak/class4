Rails.application.routes.draw do
  resources :users
  #resources :posts
  #resources is 
  # get :users
  # get '/user/:id', to: 'users#show'
  # post '/user/:id', to: 'users#create' `
  # delete 'user/:id', to: 'users#destroy'
  # . bla bla bla like rails router -g user in console
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'create_fast', to: 'users#create_fast'
  get 'users/show2' ,to: 'users#show2'
  get 'main' ,to: 'users#main'
  post 'main', to: 'users#show3'
  get 'edit2', to:'users#edit2'
  patch 'edit2', to:'users#update2'
  get 'show3', to:'users#show3'


  get 'post', to:'users#post'
  get 'post/new', to:'users#newPost'
  get 'newpost', to:'users#createPost'
  patch 'post', to:'users#updatePost'
  get 'editPost', to: 'users#editPost'
  delete 'show3', to: 'users#destroyPost'
end
