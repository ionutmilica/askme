class UsersController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_action :authenticate_user!

  respond_to :json

  def questions
    respond Question.where(to: params[:id]).all
  end

  def unanswered_questions
    respond(current_user.questions.unanswered)
  end

  def reply_question
    question = Question.where(id: params[:id], to: current_user.id).first

    if question
      question.update(reply: params[:answer], replied_at: Time.now)
      respond question
      return
    end
    respond({:message => 'Question not found!'}, false, 404)
  end

  def post_question
    if User.find_by_id(params[:id]).nil?
      respond({ :message => 'User not found!'}, false, 404)
      return
    end

    question = Question.create(from: current_user.id, to: params[:id], question: params[:question], created_at: Time.now)

    respond ({ :message => 'Message posted!', :question => question})
  end

end