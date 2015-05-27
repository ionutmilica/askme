class Notification < ActiveRecord::Base

  belongs_to :question
  belongs_to :user

  def self.like(user, question)
    n = Notification.new
    n.user_id = question.to
    n.who_id = user
    n.question_id = question.id
    n.kind = 1
    n.seen = false
    n.created_at = Time.now
    n.save
  end

  def self.reply(question)
    if question.from.nil?
      return
    end
    
    n = Notification.new
    n.user_id = question.from
    n.who_id = question.to
    n.question_id = question.id
    n.kind = 2
    n.seen = false
    n.created_at = Time.now
    n.save
  end

  def self.likes(user)
    set_seen(user, 1)
    likes = get_notifications(user, 1)
    return likes
  end

  def self.replies(user)
    set_seen(user, 2)
    replies = get_notifications(user, 2)
    return replies
  end

  def self.unseen_likes(user)
    get_unseen_notifications(user, 1)
  end

  def self.unseen_replies(user)
    get_unseen_notifications(user, 2)
  end

  def self.set_seen(user, kind)
    where(user_id: user, kind: kind).update_all(seen: true)
  end

  protected
  def self.get_notifications(user, kind)
    where(user_id: user).where(kind: kind)
  end

  def self.get_unseen_notifications(user, kind)
    where(user_id: user).where(kind: kind).where(seen: false)
  end
end
