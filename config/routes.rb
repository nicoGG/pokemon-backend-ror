Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post 'login', to: 'auth#login'
  namespace :api do
    namespace :v1 do
      get 'swagger.yaml', to: 'swagger#index'
    end
  end
  resources :pokemons, only: [:index, :show, :create, :update, :destroy] do
    collection do
      post 'capture'
      get 'captured'
    end
  end
end