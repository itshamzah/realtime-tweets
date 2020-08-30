Rails.application.routes.draw do
	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

	root "dashboard#index"
	resources :dashboard, only: [:index]
	resources :home, only: [:index]
end
