Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'user/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  get 'search_friends', to: 'users#search'
  get 'friends', to: 'users#friends'
  post 'add_friend', to: 'users#add_friend'

  resources :user_stocks, only: [:create, :destroy]
  resources :users, only: [:index, :show]
  resources :friendships
end
