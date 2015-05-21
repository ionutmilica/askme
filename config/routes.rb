Rails.application.routes.draw do

  devise_for :users

  scope 'account' do
    get 'wall', to: 'account#wall', as: 'account_wall'

    # Questions from logged-in user perspective

    get 'questions/:id/answer', to: 'account#answer', as: 'account_answer'
    post 'questions/:id/answer', to: 'account#do_answer', as: 'do_account_answer'
    get 'questions/:id', to: 'account#question', as: 'account_question'
    get 'questions', to: 'account#questions', as: 'account_questions'

    get 'follow', to: 'account#follow', as: 'account_follow'
    get 'search', to: 'account#search', as: 'account_search'
    get 'settings', to: 'account#settings', as: 'account_settings'

  end

  # Users profile
  get ':username/answer/:id', to: 'users#answer', as: 'users_answer'
  get ':username/gifts', to: 'users#gifts', as: 'users_gifts'
  get ':username/best', to: 'users#best', as: 'users_bets'
  post ':username/follow', to: 'users#profile', as: 'users_follow'
  get ':username', to: 'users#profile', as: 'users_profile'

  root 'home#index'
end
