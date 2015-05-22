class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates :username, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

  has_many :send_questions, :class_name => 'Question', :foreign_key => 'from', :dependent => :nullify
  has_many :received_questions, :class_name => 'Question', :foreign_key => 'to', :dependent => :nullify


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value", { :value =>username.downcase }]).first
    else
      where(conditions).first
    end
  end
end
