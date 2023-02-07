Rails.application.routes.draw do
  scope module: :public do
    root to: "homes#top"
    get '/about' => 'homes#about', as: 'about'
    get "search_tag" => "posts#search_tag"
    resources :posts do
      resources :post_comments, only: [:create]
    end
    resource :favorites, only: [:create, :destroy]
  end
  
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
