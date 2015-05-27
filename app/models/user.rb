class User < ActiveRecord::Base
  acts_as_followable
  acts_as_follower
  acts_as_voter
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable, :recoverable, :validatable, :rememberable

  validates :username, presence: true, length: {minimum: 3, maximum: 30}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, message: "may only contain letters and numbers." }
  validates :fullname, presence: true

  has_many :send_questions, :class_name => 'Question', :foreign_key => 'from', :dependent => :nullify
  has_many :received_questions, :class_name => 'Question', :foreign_key => 'to', :dependent => :nullify

  def total_likes
    Notification.unseen_likes(id).length
  end

  def total_replies
    Notification.unseen_replies(id).length
  end

  def create_like(question)
    likes question
    Notification.like(id, question)
    Activity.log(id, question.id)
  end

  def self.get_random(limit = 15)
    self.order_by_rand.limit(limit)
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['username = :value OR email = :value', { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        puts conditions
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def self.search(query, current)
    where(['username LIKE ?', "%#{query}%"]).where.not(id: current)
  end
end
