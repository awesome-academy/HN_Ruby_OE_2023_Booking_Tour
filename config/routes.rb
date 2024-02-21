Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :tours, :tour_details, :users, :sessions, :bookings, :relationships, :reviews
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
  end
  namespace :admin do
    scope "(:locale)", locale: /en|vi/ do
      resources :tours, :tour_details, :bookings, :homes, :tour_categories
      get 'dashboard'=> 'homes#home', as: "dashboard"
      get '/tour/:id/tourdetails' => 'tour_details#new', as: 'add_tour_detail'
      get 'cancel_booking/:id' => 'bookings#cancel_modal', as: 'cancel_booking'
      post 'cancel_booking/:id' => 'bookings#cancel', as: 'submit_cancel_booking'
      put 'confirm_booking/:id' => 'bookings#confirm', as: 'confirm_booking'
      put 'success_booking/:id' => 'bookings#success', as: 'success_booking'
      get 'filter_booking' => 'bookings#filter', as: 'filter_bookings'
    end
  end
end
