Rails.application.routes.draw do


  resources :device_models
  get 'home/index'
  get 'home/about', as: :about #, path: 'about'

  resources :people, except: :index
  resources :lines, except: :index
  get 'settings', as: :settings, to: 'settings#index'
  scope '/settings' do
    resources :offices
    resources :delegations
  end

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
