Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :tours
    resources :users
    resources :bills
    resources :sessions
    root 'tours#index'
  end
end
