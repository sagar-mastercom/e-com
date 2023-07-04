require 'sidekiq/web'
Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'

  mount Rswag::Ui::Engine => '/swagger/api-docs'


  resources :products

  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
 controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations'
 }
  get '/current_user', to: 'current_user#index'
  patch 'update_user', to: 'current_user#update_user'
  get '/all_users', to: 'current_user#all_users'

  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'

end
