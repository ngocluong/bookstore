class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
   protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :full_name
      devise_parameter_sanitizer.for(:sign_up) << :phone
      devise_parameter_sanitizer.for(:sign_up) << :birthday
      devise_parameter_sanitizer.for(:sign_up) << :creation_date
      devise_parameter_sanitizer.for(:account_update) << :full_name
      devise_parameter_sanitizer.for(:account_update) << :phone
      devise_parameter_sanitizer.for(:account_update) << :birthday
      devise_parameter_sanitizer.for(:account_update) << :creation_date
  end
end
