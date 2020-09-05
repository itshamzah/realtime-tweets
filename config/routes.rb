Rails.application.routes.draw do
	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

	get 'timeline', to: 'dashboard#index'
	get 'wall', to: 'dashboard#wall'

	root to: 'home#index'
end
