Rails.application.routes.draw do
  resources :categories do
    resources :expenses
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
