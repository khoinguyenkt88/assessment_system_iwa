Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  root "users#index"

  scope :admin do
    resources :users

    resources :tests do
      resources :questions do
        resources :options do
        end
      end
    end
  end
end
