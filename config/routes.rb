Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes do

    resources :comments, only: [:create]

    get 'search', on: :collection
    member do
      post 'favorite'
      delete 'favorite', to: 'recipes#unfavorite'
    end
  end

  resources :comments, only: [:destroy]


  namespace 'api', defaults: { format: 'json' } do
    namespace 'v1' do
      resources :recipes, only: [:index, :destroy]
    end
  end


end
