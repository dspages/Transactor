Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#new'
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :index]
  resources :transactions, only: [:create, :index]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users do
        get :current
      end
    end
  end
end
