Rails.application.routes.draw do
  #get 'home/about'
  
  root :to => "home#top"

  get "home/about" => "home#about"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :index, :edit, :update]

  resources :books

end
