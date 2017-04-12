Rails.application.routes.draw do


  get 'home/index'
  get 'home/about', as: :about #, path: 'about'

  resources :people, except: :index
  resources :lines, except: :index
  resources :settings, only: :index do
    collection do
      get :new_selector
      post :create_selector
      get :new_office
      post :create_office
      get :new_delegation
      post :create_delegation
      delete '/delete_delegation/:id', to: 'settings#delete_delegation', as: :delete_delegation
      delete '/delete_selector/:id', to: 'settings#delete_selector', as: :delete_selector
      delete '/delete_office/:id', to: 'settings#delete_office', as: :delete_office
    end
  end

  #resources :selector_settings
  #resources :offices
  #resources :delegations

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
