Rails.application.routes.draw do
  get 'welcome/index'
  get "/auth/google_oauth2/callback" => "sessions#create"
  get "log_out" => "sessions#destroy", :as => "log_out"

  root 'welcome#index'
  get 'welcome/home' => 'welcome#home', :as => 'home'

  resources :contributors do
  	resources :contributions
  end

  resources :expenses
end
