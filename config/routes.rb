Rails.application.routes.draw do

  devise_for :users

  scope '/api' do
    scope '/v1' do
      # Token routes
      scope '/token' do
        as :user do
          post 'create', to: 'sessions#create'
          delete 'destroy', to: 'sessions#destroy'
        end
      end
      scope '/users' do
        as :user do
          post 'create', to: 'registrations#create'
        end
      end
      #
    end
  end
  root 'home#index'
end
