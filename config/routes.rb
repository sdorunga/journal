Journal::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  match "/stats" => "entries#stats"
  devise_for :users
  resources :users
  resources :entries
end