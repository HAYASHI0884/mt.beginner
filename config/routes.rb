Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  get "pages/top"
  resources :pages, only:[:index, :show, :edit, :update]
  resources :mountains do
    namespace :admin do
      resources :mountains, only:[:index]
    end
  end
  resources :tweets, only:[:show, :edit, :new, :create, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
