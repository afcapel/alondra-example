AlondraExample::Application.routes.draw do

  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login

  resources :users
  resources :sessions

  resources :chat_rooms do
    resources :messages
  end

  root :to => 'chat_rooms#index'
end
