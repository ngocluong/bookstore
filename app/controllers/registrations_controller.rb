class RegistrationsController < Devise::RegistrationsController
  layout false,  only: [:new, :create]
  respond_to :js

  def create
    super do |resource|
      @after_sign_up_path = after_sign_up_path_for(resource)
    end
  end
end
