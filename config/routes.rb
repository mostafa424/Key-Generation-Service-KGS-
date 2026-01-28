Rails.application.routes.draw do
  get 'keys' =>"key_tokens#index"
  get 'keys/remaining' => "key_tokens#remaining"
  patch 'keys/get_key' => "key_tokens#get_key"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  post 'keys' => "key_tokens#generate_keys"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  post "keys/release_key" => "key_tokens#release_key"
  # Defines the root path route ("/")
  # root "posts#index"
end
