class User < ActiveRecord::Base
  acts_as_followable
  acts_as_follower
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates :username, presence: true, length: {minimum: 3, maximum: 30}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }

  has_many :send_questions, :class_name => 'Question', :foreign_key => 'from', :dependent => :nullify
  has_many :received_questions, :class_name => 'Question', :foreign_key => 'to', :dependent => :nullify


  def total_likes
    total = 0
    received_questions.each do |question|
      total += question.cached_votes_up
    end
    total
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if username = conditions.delete(:username)
      where(conditions).where(["lower(username) = :value", { :value =>username.downcase }]).first
    else
      where(conditions).first
    end
  end
end
