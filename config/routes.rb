Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  root 'home#index'
  get '/home/about', to: 'home#about', as: :home_about
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
