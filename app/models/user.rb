class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :async, :lockable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :full_name, presence: true
  validates :birthday, presence: true, unless: :from_facebook?
  validates :phone, 
    presence: true,
    format: { with: /\d{3}-\d{3}-\d{4}/, message: 'phone number should following format: xxx-xxx-xxxx' },
    unless: :from_facebook?

  MAX_FAILED_LOGIN = 2

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private
  def from_facebook?
    provider == 'facebook' && uid.present?
  end
end

