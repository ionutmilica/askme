class SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!, :only => [:create]
  respond_to :json

  def create
    respond_to do |format|
      format.json {
        resource = resource_from_credentials
        return invalid_login_attempt unless resource
        if resource.valid_password?(params[:password])
          render :json => { user: { username: resource.username, email: resource.email, :auth_token => resource.auth_token } }, success: true, status: :created
        else
          invalid_login_attempt
        end
      }
    end
  end

  def destroy
    respond_to do |format|
      format.json {
        user = User.find_by_auth_token(request.headers['X-AUTH-TOKEN'])
        if user
          user.reset_auth_token!
          render :json => { :message => 'Session deleted.' }, :success => true, :status => 200
        else
          render :json => { :message => 'Invalid token.' }, :status => 404
        end
      }
    end
  end

  protected
  def invalid_login_attempt
    warden.custom_failure!
    render json: { success: false, message: 'Error with your login or password' }, status: 401
  end

  def resource_from_credentials
    data = { username: params[:username] }
    if res = resource_class.find_for_database_authentication(data)
      if res.valid_password?(params[:password])
        res
      end
    end
  end
end