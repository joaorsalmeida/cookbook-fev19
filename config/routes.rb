Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes do
    get 'search', on: :collection
    member do
      post 'favorite'
      delete 'favorite', to: 'recipes#unfavorite'
    end
  end
end
