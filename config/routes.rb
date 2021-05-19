Rails.application.routes.draw do
  resources :authors, only: [:show, :index] do
  resources :posts, only: [:show, :index, :new, :edit]
end# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :posts
end
