Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }

  scope '/api' do
    scope '/v1' do
      resources :sessions
    end
  end
  root 'home#index'
end
