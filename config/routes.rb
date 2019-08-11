Rails.application.routes.draw do
  resources :categories do
    resources :expenses
  end
end
