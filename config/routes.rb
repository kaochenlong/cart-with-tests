Rails.application.routes.draw do
  resources :products do
    member do
      put :add_to_cart
    end
  end

  root "products#index"
end
