Rails.application.routes.draw do


  devise_for :admins
  get 'home/index'
  get 'home/about', as: :about #, path: 'about'
  resources :billings, only: :index do
    get 'process_bill_csv',  on: :collection
    post 'process_bill_csv', on: :collection
    post 'charge_items',     on: :collection
  end

  resources :people, except: :index
  resources :lines, except: :index do
    get  :control_csv, on: :collection
    post :control_csv, on: :collection
  end
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
  ## Errors pages
  get "errors/access_denied"
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
