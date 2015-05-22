class Question < ActiveRecord::Base
  belongs_to :sender, :class_name => 'User', :foreign_key => 'from'
  belongs_to :receiver, :class_name => 'User', :foreign_key => 'to'

  def profile

  end

  def self.mine(user_id, question_id)
    where(to: user_id).where(id: question_id).first
  end

  def self.answered
    where.not(reply: nil, replied_at: nil)
  end

  def self.unanswered
    where(replied_at: nil, reply: nil)
  end

  def self.create_question(user, current, params)
    question = Question.new
    question.from = current.nil? ? nil : current.id
    question.to = user.id
    question.question = params[:question]
    question.anonymous = params[:anonymous].to_i == 1 ? true : false
    question.created_at = Time.now
    question.save
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
