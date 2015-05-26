class Activity < ActiveRecord::Base

  belongs_to :question

  def self.log(user, question)
    activity = Activity.new
    activity.user_id = user
    activity.question_id = question
    activity.save
  end

  def self.get_stream_for_user(user)
    ids = []
    user.follows_by_type('User').each do |follower|
      ids.append follower.followable.id
    end
    where(user_id: ids).group(:question_id)
  end
end
