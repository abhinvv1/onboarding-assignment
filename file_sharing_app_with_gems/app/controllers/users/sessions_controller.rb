class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  rescue
    flash[:alert] = "Couldn’t find that user! Please try again"
    redirect_to new_user_session_path
  end

  def destroy
    super
    flash[:notice] = "You have been successfully logged out."
  end
end
