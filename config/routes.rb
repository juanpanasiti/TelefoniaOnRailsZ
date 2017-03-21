Rails.application.routes.draw do


  get 'home/index'
  get 'home/about', as: :about #, path: 'about'

  resources :people, except: :index
  resources :lines, except: :index
  resources :settings, only: :index do
    collection do
      get :new_selector
      post :create_selector
    end
  end

  #resources :selector_settings
  #resources :offices
  #resources :delegations

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
