Rails.application.routes.draw do
  resources :products
  root "pages#index"
end
