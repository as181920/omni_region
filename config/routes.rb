OmniRegion::Engine.routes.draw do
  resources :divisions, param: :code do
    scope module: :divisions, only: [:index, :show] do
      resources :children, only: [:index]
    end
  end
end
