class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def authenticate_user_from_token!
    username = request.headers['X-Auth-User'].presence
    auth_token = request.headers['X-Auth-Token'].presence

    user = User.find_by_username(username)
    valid = username && auth_token && auth_token.size > 5

    if valid && user && Devise.secure_compare(user.auth_token, auth_token)
      sign_in(user, store: false)
    else
      render :json => { :message => 'Wrong token code.'}, :success => false, :status => 403
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
  end

  def respond(data, success = true, status = 200)
    render :json => data, :success => success, :status => status
  end

end
