Stuwashere::Application.routes.draw do

  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: 'statics#home'
  get 'statics/about', as: 'about'
  get 'statics/contact', as: 'contact'
  get 'statics/results', as: 'results'

  resources :gear_items, path: 'gear'
  resources :gear_lists
  resources :trips
  resources :tags
  resources :posts
  resources :pictures
end
