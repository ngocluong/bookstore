class User < ActiveRecord::Base
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :async, :lockable
  validates :phone, :full_name, :birthday, presence: true
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: 'phone number should following format: xxx-xxx-xxxx' }

  MAX_FAILED_LOGIN = 2
end

