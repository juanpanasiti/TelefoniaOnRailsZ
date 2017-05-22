Rails.application.routes.draw do


  get 'home/index'
  get 'home/about', as: :about #, path: 'about'
  resources :billings, only: :index do
    get 'process_bill_csv', on: :collection
    post 'process_bill_csv', on: :collection
    post 'charge_items', on: :collection
  end

  resources :people, except: :index
  resources :lines, except: :index
  get 'settings', as: :settings, to: 'settings#index'
  scope '/settings' do
    resources :offices
    resources :delegations
    resources :devices
    resources :device_models
    resources :bill_headers
    resources :bill_items do
      post 'charge_new_items_csv', on: :collection
    end
  end

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
