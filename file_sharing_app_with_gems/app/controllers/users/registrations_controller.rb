class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_sign_up_params
    flash[:notice] = "Welcome! Your account has been created successfully."
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :email])
  end
  def configure_account_update_params
    flash[:notice] = "Thanks for signing up! Please check your email to confirm your account."
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :email])
  end
end
