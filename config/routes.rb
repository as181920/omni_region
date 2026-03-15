OmniRegion::Engine.routes.draw do
  get "welcome/index"
  get "api-docs", to: "api_docs#index", as: :api_docs
  get "api-docs/openapi.json", to: "api_docs#openapi", as: :openapi_spec
  get "api-docs/*path", to: "api_docs#openapi_file", as: :openapi_spec_file
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
