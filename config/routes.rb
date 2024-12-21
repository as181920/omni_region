OmniRegion::Engine.routes.draw do
  get "welcome/index"
  root "welcome#index"

  resources :divisions, param: :code do
    scope module: :divisions, only: %i[index show] do
      resources :children, only: [:index]
    end
  end

  resources :countries, only: [:index]
  resources :provinces, only: [:index]
  resources :cities, only: [:index]
  resources :districts, only: [:index]
end
