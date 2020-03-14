Rails.application.routes.draw do
  root "assessments#index"
  apipie

  scope :admin do
    devise_for :users, :controllers => {:registrations => "registrations"}

    resources :users

    resources :tests do
      resources :questions do
        resources :options do
        end
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users

      post :authenticate, to: 'sessions#create'

      devise_scope :user do
        resource :sessions, only: %i[create destroy]
      end

      resources :tests do
        member do
          post :save_answer
        end
      end
    end
  end
end
