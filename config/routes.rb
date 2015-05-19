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
          put 'update', to: 'registrations#update'
          # Pages
          get ':id/questions', to: 'users#questions'
          post ':id/questions', to: 'users#post_question'
        end
      end

      scope '/user' do
        get 'questions/unanswered', to: 'users#unanswered_questions'
        post 'questions/:id/reply', to: 'users#reply_question'
      end

      scope '/questions' do
        get ':id', to: 'questions#get_question'
      end
      #
    end
  end
  root 'home#index'
end
