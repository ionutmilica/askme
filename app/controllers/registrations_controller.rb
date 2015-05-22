class RegistrationsController < Devise::RegistrationsController
  protected
  def after_sign_up_path_for(resource)
    account_wall_path
  end

  def after_update_path_for(resource)
    account_wall_path
  end
end
