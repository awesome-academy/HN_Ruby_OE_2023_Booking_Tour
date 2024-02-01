Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :tours, :tour_details, :users, :bills, :sessions, :bookings
    root 'tours#home'
    get '/tour/:id/tourdetails', to: 'tour_details#new', as: 'add_tour_detail'
    get '/tour/:id/details', to: 'tours#detail', as: 'tour_tour_details'
    get 'login' => 'sessions#new'
    get 'home' => 'tours#home'
    post 'login' => 'sessions#create'
    delete 'logout' =>'sessions#destroy'
    get 'signup' => 'users#new'
    get 'cancel_booking/:id' => 'bookings#cancel', as: 'cancel_booking'
    get 'confirm_booking/:id' => 'bookings#confirm', as: 'confirm_booking'
    get 'book/:id' => 'bookings#booking', as: 'book'
  end
end
