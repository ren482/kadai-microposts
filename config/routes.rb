Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/create'
  root to: "toppages#index"
  
  
  #resources 内には、get "users_new", to: "users#new" が記述されている(newアクションがルーティングに追加されている)
  #のに、get "singup", to: "users#name"としたのは、usersコントローラのnewアクションへのURLをsingupに変更したかったから
  get "signup", to: "users#new"
  
  resources :users, only: [:index, :show, :create]
  
end
