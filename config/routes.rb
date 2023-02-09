Rails.application.routes.draw do
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
    end
    resource :favorites, only: [:create, :destroy]
    resources :customers, only: [:index, :show, :edit, :update] do
      get :favorites, on: :member
    end
  end
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
