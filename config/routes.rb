Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :tours, :tour_details, :users, :sessions, :bookings, :relationships
    resources :bookings do
      resources :reviews, only: %i(new create)
    end
    resources :reviews , only: %i(destroy edit update)
    root 'tours#home'
    get 'login' => 'sessions#new'
    get 'home' => 'tours#home'
    post 'login' => 'sessions#create'
    delete 'logout' =>'sessions#destroy'
    get 'cancel_booking/:id' => 'bookings#cancel', as: 'cancel_booking'
    get 'signup' => 'users#new'
    get 'book/:id' => 'bookings#new', as: 'book'
    get 'booking_history' => 'bookings#booking_history', as:'history'
    get 'tour_following' => 'users#following_tour', as: 'tour_following'
    get 'follow/:id' => 'relationships#create', as: 'follow_tour'
    get 'review/:id' => 'reviews#new', as: 'review_tour'
    delete 'unfollow/:id' => 'relationships#destroy', as: 'unfollow_tour'

    namespace :admin do
      resources :tours, :tour_details, :bills, :homes, :tour_categories
      get 'dashboard'=> 'homes#home', as: "dashboard"
      get '/tour/:id/tourdetails' => 'tour_details#new', as: 'add_tour_detail'
      put 'cancel_booking/:id' => 'bills#cancel', as: 'cancel_booking'
      put 'confirm_booking/:id' => 'bills#confirm', as: 'confirm_booking'
    end
  end
end
