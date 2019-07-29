Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts  do
    resources :comments
  end

  resources :likes, except: [:index, :new, :create, :edit, :update, :show, :destroy] do
    collection do
      get ':object_type/:object_id/likes', to: 'likes#index', as: 'index'
      post ':object_type/:object_id/likes', to: 'likes#create', as: 'create'
      put ':object_type/:object_id/likes', to: 'likes#update', as: 'update'
      delete ':object_type/:object_id/likes', to: 'likes#destroy', as: 'destroy'
    end
  end

  resources :users do
    resources :friendships, except: [:index, :new, :create, :edit, :update, :show, :destroy] do
      collection do
        post :add, to: 'friendships#add'
        post :unfriend, to: 'friendships#unfriend'
        post :accept, to: 'friendships#accept'
        post :reject, to: 'friendships#reject'
        delete :cancelled, to: 'friendships#cancelled'
      end
    end
  end
end
