Rails.application.routes.draw do
  get 'home/index'
  get 'home/about', as: :about #, path: 'about'

  resources :people, except: :index
  resources :lines, except: :index
  resources :selector_settings, except: :show

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
