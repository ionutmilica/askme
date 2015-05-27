Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations',  sessions: 'users/sessions', passwords: 'users/passwords' }

  scope 'account' do
    get 'wall', to: 'account#wall', as: 'account_wall'

    # Questions from logged-in user perspective

    get 'questions/:id/answer', to: 'account#answer', as: 'account_answer'
    patch 'questions/:id/answer', to: 'account#do_answer', as: 'do_account_answer'
    get 'questions/:id', to: 'account#question', as: 'account_question'
    delete 'questions/:id', to: 'account#delete_question', as: 'account_delete_question'
    delete 'questions/:id/answer', to: 'account#delete_answer', as: 'account_delete_answer'

    post 'questions/random', to: 'account#random_question', as: 'account_random_question'

    get 'questions', to: 'account#questions', as: 'account_questions'
    delete 'questions', to: 'account#delete_questions', as: 'account_delete_questions'

    # Like and unlike question
    post 'questions/:id/like', to: 'likes#like', as: 'like_question'

    get 'follows', to: 'account#follows', as: 'account_follow'
    get 'search', to: 'account#search', as: 'account_search'
    post 'search', to: 'account#do_search', as: 'account_do_search'

    scope 'notifications' do
      get 'perks', to: 'notifications#perks', as: 'account_notifications_perks'
      get 'answers', to: 'notifications#answers', as: 'account_notifications_answers'
    end

    scope 'settings' do
      get 'profile', to: 'settings#profile', as: 'account_settings'
      patch 'profile', to: 'settings#update_profile', as: 'account_settings_update'
      # Avatar
      get 'avatar', to: 'settings#avatar', as: 'account_settings_avatar'
      patch 'avatar', to: 'settings#update_avatar', as: 'account_settings_avatar_update'

    end
  end

  # Users profile
  get ':username/answer/:id', to: 'profile#answer', as: 'profile_answer'
  get ':username/gifts', to: 'profile#gifts', as: 'profile_gifts'
  get ':username/best', to: 'profile#best', as: 'profile_best'
  post ':username/follow', to: 'profile#follow', as: 'profile_follow'
  post ':username/unfollow', to: 'profile#unfollow', as: 'profile_unfollow'
  post ':username/ask', to: 'profile#ask', as: 'profile_ask'
  get ':username', to: 'profile#answers', as: 'profile_answers'

  root 'home#home'
end
