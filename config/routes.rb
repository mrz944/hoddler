Rails.application.routes.draw do
  resources :tickers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tickers#index"
end
