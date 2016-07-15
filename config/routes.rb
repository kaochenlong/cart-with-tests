Rails.application.routes.draw do
  devise_for :users
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

  resources :orders, only: [:create] do
    member do
      get :pay
    end
    collection do
      post :finish
    end
  end

  namespace :api do
    namespace :v1 do
      post :pay2go_callback, to: "pay2go#callback"
    end
  end

  root "products#index"
end
