class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def perks
    @notifications = Notification.likes current_user.id
  end

  def answers
    @notifications = Notification.replies current_user.id
  end
end