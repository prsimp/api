Rails.application.routes.draw do
  defaults format: :json do
    resources :users, only: [:index, :show] do
      get 'whois' => 'users#whois'
      resources :profiles, only: [:index, :show]
      get 'background' => 'facts#background'
      get 'whyharvest' => 'facts#whyharvest'
      get 'whyhire' => 'facts#whyhire'
      get 'random' => 'facts#random'
      resources :facts, only: [:index, :show]
    end
  end
end
