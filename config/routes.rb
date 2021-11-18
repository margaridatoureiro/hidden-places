Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard'
  resources :places do
    resources :reviews, only: %i[new create] do
      resources :likes, only: %i[create] do
        collection do
          delete :destroy
        end
      end
    end
  end

  resources :places do
    resources :favourites, only: %i[create] do
      collection do
        delete :destroy
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
