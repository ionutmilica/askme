class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)

    resource.save

    yield resource if block_given?

    if resource.persisted?
      render :json => { :message => 'User created.', :user => resource }, :success => true, :status => 200
      # User created
    else
      # Not created
      render :json => { :message => 'User not created.', :errors => resource.errors }, :success => false, :status => 421
    end
  end

  def update
    # Update user profile
  end

  def destroy
    # Delete user account
  end
end