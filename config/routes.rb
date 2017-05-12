Rails.application.routes.draw do


  get 'home/index'
  get 'home/about', as: :about #, path: 'about'
  get 'billing/index', as: 'billing'

  resources :people, except: :index
  resources :lines, except: :index
  get 'settings', as: :settings, to: 'settings#index'
  scope '/settings' do
    resources :offices
    resources :delegations
    resources :devices
    resources :device_models
    resources :bill_headers
    resources :bill_items
  end

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
