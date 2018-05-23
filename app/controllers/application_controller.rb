class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # http://www.rubydoc.info/github/plataformatec/devise/Devise/ParameterSanitizer

  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :danger, :info, :warning, :success

  def after_sign_in_path_for(resource)
    notifications_path
  end


  protected

  def configure_permitted_parameters
    # Permit the `field` parameter along with the other
    # sign up parameters.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :user_type, :username, :email])
    # Removing the `password` parameter from the `account_update` action.
    devise_parameter_sanitizer.permit(:account_update, except: [:password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :user_type, :username, :email])
  end
end
