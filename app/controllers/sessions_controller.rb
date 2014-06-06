class SessionsController < Devise::SessionsController
  layout false
  respond_to :js
  before_filter :captcha_eligible, :validate_captcha, only: [:create]

  # Original code
  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message(:notice, :signed_in) if is_flashing_format?
  #   sign_in(resource_name, resource)
  #   yield resource if block_given?
  #   respond_with resource, location: after_sign_in_path_for(resource)
  # end

  def create
    super do |resource|
      @after_sign_in_path = after_sign_in_path_for(resource)
    end
  end

  private
  #TODO - Move to Service object
  def captcha_eligible
    flash[:show_captcha] = User.exists?(['email = ? and failed_attempts > ?', params[:user][:email], User::MAX_FAILED_LOGIN])
  end

  def validate_captcha
    if flash[:show_captcha].present? && params[:recaptcha_challenge_field].present? && !verify_recaptcha
      respond_to do |format|
        format.js { render :new }
      end
    end
  end
end
