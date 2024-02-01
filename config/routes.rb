Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :tours
    resources :users
    resources :bills
    resources :sessions
    root 'tours#home'
    get 'login' => 'sessions#new'
    get 'home' => 'tours#home'
    post 'login' => 'sessions#create'
    delete 'logout' =>'sessions#destroy'
    get 'signup' => 'users#new'
  end
end
