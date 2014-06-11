class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :load_categories

  protected
  def configure_permitted_parameters
    [:full_name, :phone, :birthday, :creation_date].each do |attr|
      devise_parameter_sanitizer.for(:sign_up) << attr
      devise_parameter_sanitizer.for(:account_update) << attr
    end
  end

  private
  def load_categories
    @categories = Category.all
  end
end
