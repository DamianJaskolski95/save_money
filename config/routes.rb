Rails.application.routes.draw do
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :balances
    resources :cycles
    resources :categories do
      get 'countz', to: 'categories#countz'
      resources :expenses
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

  resources :apidocs, only: [:index]
end
