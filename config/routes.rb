Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :tours, :tour_details, :users, :bills, :sessions, :bookings
    root 'tours#home'
    get 'login' => 'sessions#new'
    get 'home' => 'tours#home'
    post 'login' => 'sessions#create'
    delete 'logout' =>'sessions#destroy'
    get 'signup' => 'users#new'
  end
  namespace :admin do
    scope "(:locale)", locale: /en|vi/ do
      resources :tours, :tour_details, :users
      get '/tour/:id/tourdetails', to: 'tour_details#new', as: 'add_tour_detail'
    end
  end
end
