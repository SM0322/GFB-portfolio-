Rails.application.routes.draw do
  namespace :public do
    get 'posts/new'
    post 'posts' => "posts#create"
    get 'posts/index'
    get 'posts/:id' => 'posts#show', as: 'post'
    get 'posts/:id/edit' => 'posts#edit', as: 'edit'
    patch 'posts/:id' => 'posts#update', as: 'update'
    delete 'posts/:id' => 'posts#destroy', as: 'destroy'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
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
