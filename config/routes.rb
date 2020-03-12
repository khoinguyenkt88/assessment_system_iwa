Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  root "users#index"

  resources :users do

  end

  resources :tests do
  end
end
