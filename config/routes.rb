Rails.application.routes.draw do
  resources :profiles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  patch "profiles/:id/scan", to: "profiles#scan"
  root "application#home"
end
