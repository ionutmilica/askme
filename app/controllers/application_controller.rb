class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :save_action_name
  before_filter :mine_account_setup


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
  end

  def save_action_name
    @current_action = action_name
  end

  private
  def mine_account_setup
    # Global data available to the current user
    if current_user
      @unanswered = current_user.received_questions.unanswered
    end
  end
end
