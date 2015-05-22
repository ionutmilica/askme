Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations',  sessions: 'users/sessions' }

  scope 'account' do
    get 'wall', to: 'account#wall', as: 'account_wall'

    # Questions from logged-in user perspective

    get 'questions/:id/answer', to: 'account#answer', as: 'account_answer'
    post 'questions/:id/answer', to: 'account#do_answer', as: 'do_account_answer'
    get 'questions/:id', to: 'account#question', as: 'account_question'
    get 'questions', to: 'account#questions', as: 'account_questions'

    get 'follows', to: 'account#follows', as: 'account_follow'
    get 'search', to: 'account#search', as: 'account_search'
    get 'settings', to: 'account#settings', as: 'account_settings'

  end

  # Users profile
  get ':username/answer/:id', to: 'profile#answer', as: 'users_answer'
  get ':username/gifts', to: 'profile#gifts', as: 'users_gifts'
  get ':username/best', to: 'profile#best', as: 'users_bets'
  post ':username/follow', to: 'profile#follow', as: 'users_follow'
  get ':username', to: 'profile#answers', as: 'users_profile'

  root 'home#home'
end
