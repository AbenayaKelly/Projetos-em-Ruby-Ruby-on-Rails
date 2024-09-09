class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nome])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nome])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
  def after_sign_in_path_for(resource)
    eventos_path
    end
end
