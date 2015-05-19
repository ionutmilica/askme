class Question < ActiveRecord::Base
  belongs_to :user

  def self.unanswered
    where(replied_at: nil)
  end
end
