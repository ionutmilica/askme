Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }

  scope '/api' do
    scope '/v1' do
      # Token routes
      scope '/token' do
        as :user do
          post 'create', to: 'sessions#create'
          delete 'destroy', to: 'sessions#destroy'
        end
      end
      #
    end
  end
  root 'home#index'
end
