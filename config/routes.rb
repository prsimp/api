Api::Application.routes.draw do

  resources :users, only: [:index, :show] do
    match 'whois' => 'users#whois', via: :get
    resources :profiles, only: [:index, :show]
    match 'background' => 'facts#background', via: :get
    match 'whyharvest' => 'facts#whyharvest', via: :get
    match 'whyhire' => 'facts#whyhire', via: :get
    match 'random' => 'facts#random', via: :get
    resources :facts, only: [:index, :show]
  end
end
