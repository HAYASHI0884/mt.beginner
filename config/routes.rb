Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: 'pages#index'
  get "pages/top"
  resources :pages, only:[:index, :show, :edit, :update]
  resources :mountains do
    namespace :admin do
      resources :mountains, only:[:index]
    end
  end
  resources :tweets, only:[:show, :edit, :new, :create, :update, :destroy]
  resources :rooms, only:[:new, :create, :destroy] do
    resources :messages, only:[:index, :create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
