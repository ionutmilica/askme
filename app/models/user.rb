class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :validatable
  before_save :ensure_authentication_token!

  attr_accessor :login

  validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

  has_many :questions, :foreign_key => 'to'

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value", { :value =>username.downcase }]).first
    else
      where(conditions).first
    end
  end

  def generate_secure_token_string
    SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
  end

  def ensure_authentication_token!
    if auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end

  def generate_auth_token
    loop do
      token = generate_secure_token_string
      break token unless User.where(auth_token: token).first
    end
  end

  def reset_auth_token!
    self.auth_token = ''
    save
  end
end
