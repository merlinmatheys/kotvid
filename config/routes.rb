Rails.application.routes.draw do
  get '/rgpd', to: 'pages#rgpd', as: 'rgpd'
  get '/cgu', to: 'pages#cgu', as: 'cgu'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'kots#index'
  resources :kots, except: :index

end
