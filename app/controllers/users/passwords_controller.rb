class Users::PasswordsController < Devise::PasswordsController
  def after_resetting_password_path_for(resource_name)
    account_wall_path
  end
end