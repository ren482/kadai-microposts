Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  root to: "toppages#index"
  
  
  #resources 内には、get "users_new", to: "users#new" が記述されている(newアクションがルーティングに追加されている)
  #のに、get "singup", to: "users#name"としたのは、usersコントローラのnewアクションへのURLをsingupに変更したかったから
  get "signup", to: "users#new"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :users, only: [:index, :show, :new, :create]
  
end
