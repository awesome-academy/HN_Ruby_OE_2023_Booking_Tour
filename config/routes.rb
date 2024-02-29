Rails.application.routes.draw do
  devise_for :users , controllers: {sessions: "devise/sessions",
                                    registrations: "devise/registrations",
                                    confirmations: "devise/confirmations",
                                    omniauth_callbacks: 'users/omniauth_callbacks'}
  scope "(:locale)", locale: /en|vi/ do
    resources :tours, only: %i(home index show)
    resources :users, only: %i(index show)
    resources :bookings, only: %i(create cancel show booking_following) do
      resources :reviews, only: %i(new create)
    end
    as :user do
      get "signin" => "devise/sessions#new", as: "login"
      post "signin" => "devise/sessions#create"
      delete "signout" => "devise/sessions#destroy"
      get "signup" => "devise/registrations#new"
    end
    resources :reviews , only: %i(destroy edit update)
    root 'tours#home'
    get 'home' => 'tours#home'
    get 'cancel_booking/:id' => 'bookings#cancel', as: 'cancel_booking'
    get 'book/:id' => 'bookings#new', as: 'book'
    get 'booking_history' => 'bookings#booking_history', as:'history'
    get 'tour_following' => 'users#following_tour', as: 'tour_following'
    get 'follow/:id' => 'relationships#create', as: 'follow_tour'
    get 'review/:id' => 'reviews#new', as: 'review_tour'
    delete 'unfollow/:id' => 'relationships#destroy', as: 'unfollow_tour'

    namespace :admin do
      resources :tours, :tour_details, :homes, :tour_categories
      resources :bills, only: %i(index cancel confirm) do
        collection do
          get "filter", to: "bills#filter"
        end
      end
      get 'dashboard'=> 'homes#home', as: "dashboard"
      get '/tour/:id/tourdetails' => 'tour_details#new', as: 'add_tour_detail'
      put 'cancel_booking/:id' => 'bills#cancel', as: 'cancel_booking'
      put 'confirm_booking/:id' => 'bills#confirm', as: 'confirm_booking'
    end
  end
end
