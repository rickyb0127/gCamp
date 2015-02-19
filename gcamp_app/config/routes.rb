Rails.application.routes.draw do
  root 'welcome#index'
  get '/terms', to: 'terms#index'
  get '/about', to: 'about#index'
  get '/faq', to: 'common_questions#index'
  get '/users', to: 'users#index'
  resources :tasks
  resources :users
  resources :projects
end
