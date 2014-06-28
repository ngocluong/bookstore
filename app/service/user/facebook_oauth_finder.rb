class User
  class FacebookOauthFinder
    attr_accessor :auth

    def self.find_oauth_user(*args)
      new(*args).oauth_user
    end

    def initialize(options = {})
      self.auth = options[:auth]
    end

    def oauth_user
      User.where(auth_finder_params).first_or_create { |user| user.assign_attributes(auth_creation_attributes) }
    end

    private
    def auth_finder_params
      @auth_finder_params ||= auth.slice(:provider, :uid)
    end

    def auth_creation_attributes
      @auth_creation_attributes ||= {
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token,
        full_name: auth.info.name,
        creation_date: Time.now,
        confirmed_at: Time.now
      }
    end
  end
end
