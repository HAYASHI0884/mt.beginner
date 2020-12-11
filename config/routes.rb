Rails.application.routes.draw do
  resources :tweets, only:[:show, :edit, :update, :create, :update, :destroy]
  devise_for :users
  root to: 'pages#index'
  get "pages/top"
  resources :pages, only:[:index, :show, :edit, :update]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
