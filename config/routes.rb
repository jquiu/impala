Rails.application.routes.draw do
  root 'offers#index'
  resources :offers
  resources :measures
  resources :comments
  resources :locations
  resources :products
  devise_for :users
  resources :users, :except => [:edit]
  match 'comments/send_mail', to: 'comments#send_mail', via: 'post'
  get  "offers/download", to: "offers#download"
  post  "offers/extend", to: "offers#extend", as: "extend"
  post "offers/create_offer_user", to: "offers#create_offer_user", as: "create_offer_user"
  post "offers/change_status" => "offers#change_status"
  post "users/create_user", to: "users#create_user", as: "create_user"
end
