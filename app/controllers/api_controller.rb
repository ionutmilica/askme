class ApiController < ActionController::Base
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json'}

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def authenticate_user_from_token!
    user_email = request.headers['X-Auth-Email'].presence
    user_auth_token = request.headers['X-Auth-Token'].presence

    user = user_email && User.find_by_email(user_email) && user_auth_token.size > 5

    if user && Devise.secure_compare(user.auth_token, user_auth_token)
      sign_in(user, store: false)
    end
  end
end