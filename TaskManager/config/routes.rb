Rails.application.routes.draw do
  devise_for :users
  resources :tasks do
    member do
      patch :mark_as_completed
    end
  end
  root 'tasks#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :tasks
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end


  # Defines the root path route ("/")
  # root "posts#index"
end
