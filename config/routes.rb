Rails.application.routes.draw do

  devise_for :users

  scope 'account' do
    get 'wall', to: 'account#wall', name: 'account_wall_path'
    get 'questions', to: 'account#questions', name: 'account_questions_path'
    get 'follow', to: 'account#follow', name: 'account_follow_path'
    get 'search', to: 'account#search', name: 'account_search_path'
    get 'settings', to: 'account#settings', name: 'account_settings_path'

  end

  root 'home#index'
end
