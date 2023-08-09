Rails.application.routes.draw do
  root "projects#index"
  devise_for :users
  namespace :admin do
    resources :users do
      member do
        put :make_admin
        put :update_password
      end
    end
  end

  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :projects do
    resources :attachments, only: [:new, :create, :destroy]
    resources :topics do
      resources :messages
    end
    post 'add_user', on: :member
  end

end
