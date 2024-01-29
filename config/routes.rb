Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :tours, :tour_details, :users, :bills, :sessions, :bills
    root 'tours#home'
    get '/tour/:id/tourdetails', to: 'tour_details#new', as: 'add_tour_detail'
    get 'login' => 'sessions#new'
    get 'home' => 'tours#home'
    post 'login' => 'sessions#create'
    delete 'logout' =>'sessions#destroy'
    get 'signup' => 'users#new'
    get 'booking/:id' => 'bills#booking', as: 'booking'
  end
end
