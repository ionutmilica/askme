Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do

    end
  end
  root 'home#index'
end
