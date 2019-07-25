Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts  do
    resources :comments
  end

  resources :users do
    resources :friendships, except: [:index, :new, :create, :edit, :update, :show, :destroy] do
      collection do
        post :add, to: 'friendships#add'
        post :unfriend, to: 'friendships#unfriend'
      end
    end
  end
end
