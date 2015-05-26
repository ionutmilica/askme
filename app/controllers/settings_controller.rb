class SettingsController < ApplicationController
  before_action :authenticate_user!

  def profile

  end

  def update_profile
    current_user.update_attributes profile_params
    render 'settings/profile'
  end

  def avatar

  end

  def update_avatar
    current_user.update params.require(:user).permit(:avatar)
    render 'settings/avatar'
  end

  protected
  def profile_params
    params.require(:user).permit(:email, :description, :location, :title, :fullname)
  end
end