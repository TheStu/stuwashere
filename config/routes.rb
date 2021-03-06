Stuwashere::Application.routes.draw do

  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root to: 'statics#home'
  get 'statics/about', as: 'about', path: 'about'
  get 'statics/contact', as: 'contact', path: 'contact'
  get 'statics/results', as: 'results', path: 'results'
  get 'statics/photography', as: 'photography', path: 'photography'
  get 'statics/web_design', as: 'web_design', path: 'web-design'

  resources :gear_items, path: 'gear', except: :index
  resources :gear_lists, except: :index
  resources :trips, except: :index
  resources :tags, except: :index
  resources :posts
  resources :pictures, except: :index
end
