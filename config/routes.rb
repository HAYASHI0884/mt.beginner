Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root to: 'pages#index'
  get "pages/top"
  get "pages/explain"
  resources :pages, only:[:index, :show, :edit, :update]
  resources :mountains
  namespace :admin do
    resources :mountains, only:[:index]
  end
  resources :tweets
  resources :rooms, only:[:new, :create, :destroy, :show] do
    resources :messages, only:[:index, :create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
