class Question < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User', :foreign_key => 'from'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'to'

  def self.mine(user_id, question_id)
    where(to: user_id).where(id: question_id).first
  end

  def self.unanswered
    where(replied_at: nil, reply: nil)
  end

  def self.answer(user_id, question_id, params)
    params[:replied_at] = Time.now

    question = self.mine user_id, question_id
    if question
      question.update!(params)
    end

    question
  end
end
