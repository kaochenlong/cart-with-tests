Rails.application.routes.draw do
  resources :products do
    member do
      put :add_to_cart
    end
  end

  resource :cart, only: [:show, :destroy] do
    collection do
      get :checkout
    end
  end

  root "products#index"
end
