class SettingsController < ApplicationController
  before_action :authenticate_user!

  def profile

  end

  def update_profile
    current_user.update profile_params
    redirect_to account_settings_path
  end

  def avatar

  end

  def update_avatar
    current_user.update params.require(:user).permit(:avatar)
    redirect_to account_settings_avatar_path
  end

  protected
  def profile_params
    params.require(:user).permit(:email, :description, :location, :title, :fullname)
  end
end