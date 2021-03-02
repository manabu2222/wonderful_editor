Rails.application.routes.draw do
  namespace :api do
    namespace :vi do
      mount_devise_token_auth_for "User", at: "auth"
      resources :articles
    end
  end
end
