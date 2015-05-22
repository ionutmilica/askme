class Followership < ActiveRecord::Base
  validate :does_not_follow_self

  belongs_to :user, :class_name => 'User'
  belongs_to :follower, :class_name => 'User'

  def self.num_followers(user_id)
    where(user_id: user_id).count
  end

  def self.follows(follower_id)
    where(follower_id: follower_id)
  end

  def self.follow(user_id, follower_id)
    Followership.create(user_id: user_id, follower_id: follower_id)
  end

  protected
  def does_not_follow_self
    errors.add(:base, 'You can\'t follow yourself') if user == follower
  end
end
