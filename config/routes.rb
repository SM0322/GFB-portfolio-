Rails.application.routes.draw do
  # namespace :public do
  #   get 'relationships/followings'
  #   get 'relationships/followers'
  # end
  
  devise_scope :customer do
    post 'customers/guest_log_in', to: 'public/sessions#guest_log_in'
  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    get "search_tag" => "posts#search_tag"
    get "search" => "searches#search"
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/:id/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :customers, only: [:index, :show, :edit, :update] do
      get :favorites, on: :member
      resource :relationships, only: [:create, :destroy]
      get '/followings' => 'relationships#followings', as: 'followings'
      get '/followers' => 'relationships#followers', as: 'followers'
      get :follow_posts, on: :member
    end
    resources :groups, except: [:destroy]
  end
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    root to: "homes#top"
    resources :customers, only: [:index, :show, :edit, :update] do
      get :post_comments, on: :member
    end
    get "search_tag" => "posts#search_tag"
    get "search" => "searches#search"
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :post_comments, only: [:destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
