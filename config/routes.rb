Rails.application.routes.draw do
  resources :actions
  resources :moms
  resources :meets
  resources :agendas
  devise_for :users

  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/about'
  get 'home/new'
  get 'home/delete'
  get 'home/delete2'
  get 'home/see_your'
  get 'admin/index'
  get 'admin/edit'
  get 'admin/update'
  get 'admin/new'
  get 'admin/sign_out2'
  get 'home/index2'
  post '/admin/new', to: 'admin#create'
  resources :admin, only: [:edit, :update]

end
