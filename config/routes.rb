Rails.application.routes.draw do
  get '/rgpd', to: 'pages#rgpd', as: 'rgpd'
  get '/cgu', to: 'pages#cgu', as: 'cgu'
  get 'aiglon_populer', to: 'kots#aiglon_populer'
  get 'aiglon_update', to: 'kots#aiglon_update'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'kots#index'
  resources :kots, except: :index do
    collection do
      get :mykots, as: 'mes_kots'
    end
  end
end
